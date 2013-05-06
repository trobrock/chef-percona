include_recipe "percona::client"

case node['platform']
when "rhel", "centos"
  package "Percona-Server-server-#{node['percona']['version'].gsub(/\./, '')}"
when "debian", "ubuntu"
  package "percona-server-server-#{node['percona']['version']}"
end

service "mysql" do
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action [:enable, :start]
end
