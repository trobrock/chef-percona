include_recipe "percona"

case node['platform']
when "rhel", "centos"
  case node['percona']['version']
  when "5.1"
    filename = "Percona-Server-client-51-5.1.68-rel14.6.551.rhel6.x86_64.rpm"
    url      = "http://www.percona.com/downloads/Percona-Server-5.1/Percona-Server-5.1.68-14.6/RPM/rhel6/x86_64/"
  end
  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source "#{url}#{filename}"
  end

  rpm_package "#{filename.sub(/\.rpm/, '')}" do
    source "#{Chef::Config[:file_cache_path]}/#{filename}"
  end
when "debian", "ubuntu"
  package "percona-server-client-#{node['percona']['version']}"
end
