include_recipe "percona"

case node['platform']
when "rhel", "centos"
  package "Percona-Server-client-#{node['percona']['version'].gsub(/\./, '')}"
when "debian", "ubuntu"
  package "percona-server-client-#{node['percona']['version']}"
end
