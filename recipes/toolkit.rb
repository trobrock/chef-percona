include_recipe "percona"

case node['platform']
when "rhel", "centos"
  url      = "http://percona.com/get/"
  filename = "percona-toolkit.rpm"
  checksum = "4af394831ce11e74b0b3db70eec0d02f5b4540927d777f4dbde56322e0c7fca9"

  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source   "#{url}#{filename}"
    checksum checksum
  end

  %w{ perl-DBI perl-DBD-MySQL perl-Time-HiRes perl-IO-Socket-SSL }.each do |p|
    package p
  end

  rpm_package "#{filename.sub(/\.rpm/, '')}" do
    source "#{Chef::Config[:file_cache_path]}/#{filename}"
  end
when "debian", "ubuntu"
  # TODO: do this
end

