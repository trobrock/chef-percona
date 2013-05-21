#
# Cookbook Name:: percona
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

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
  # I know this won't work straight out,
  # but we don't run Ubuntu and I don't have
  # time to work this out on Ubuntu/Debian yet.
  execute "gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A"
  execute "gpg -a --export CD2EFD2A | sudo apt-key add -"
  execute "echo 'deb http://repo.percona.com/apt VERSION main
  deb-src http://repo.percona.com/apt VERSION main' > /etc/apt/sources.list"
end
