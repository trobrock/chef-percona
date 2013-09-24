#
# Cookbook Name:: percona
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when 'rhel', 'centos'
  include_recipe "yum"
when 'debian', 'ubuntu'
  include_recipe "apt"
end

# Remove the mysql package, as it conflicts with percona
package "mysql" do
  action :remove
end

case node['platform']
when 'rhel', 'centos'
  case node['percona']['version']
  when "5.1"
    filename = "Percona-Server-shared-51-5.1.68-rel14.6.551.rhel6.x86_64.rpm"
    url      = "http://www.percona.com/downloads/Percona-Server-5.1/Percona-Server-5.1.68-14.6/RPM/rhel6/x86_64/"
    checksum = "892077b37dc31bcd18f8ee886ee07aa90bd368751efb8384010de72af282f9d9"
  end
  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source   "#{url}#{filename}"
    checksum checksum
  end

  rpm_package "#{filename.sub(/\.rpm/, '')}" do
    source "#{Chef::Config[:file_cache_path]}/#{filename}"
  end
when 'debian', 'ubuntu'
  apt_repository 'percona' do
    uri          'http://repo.percona.com/apt'
    distribution node['lsb']['codename']
    components   ['main']
    keyserver    'keys.gnupg.net'
    key          '1C4CBDCDCD2EFD2A'
  end
end
