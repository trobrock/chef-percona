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
  execute "Configure percona repo" do
    command "rpm -Uhv http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm"
    not_if "yum repolist percona | grep percona"
  end

  package "Percona-Server-shared-#{node['percona']['version'].gsub(/\./, '')}"
when 'debian', 'ubuntu'
  # I know this won't work straight out,
  # but we don't run Ubuntu and I don't have
  # time to work this out on Ubuntu/Debian yet.
  execute "gpg --keyserver  hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A"
  execute "gpg -a --export CD2EFD2A | sudo apt-key add -"
  execute "echo 'deb http://repo.percona.com/apt VERSION main
  deb-src http://repo.percona.com/apt VERSION main' > /etc/apt/sources.list"
end
