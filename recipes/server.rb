include_recipe "percona::client"

case node['platform']
when "rhel", "centos"
  filename = "Percona-Server-server-51-5.1.68-rel14.6.551.rhel6.x86_64.rpm"
  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source "http://www.percona.com/downloads/Percona-Server-5.1/Percona-Server-5.1.68-14.6/RPM/rhel6/x86_64/#{filename}"
  end

  rpm_package "#{filename.sub(/\.rpm/, '')}" do
    source "#{Chef::Config[:file_cache_path]}/#{filename}"
  end
when "debian", "ubuntu"
  package "percona-server-server-#{node['percona']['version']}"
end

service "mysql" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [:enable, :start]
end
