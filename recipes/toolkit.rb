include_recipe "percona"

case node['platform']
when "rhel", "centos"
  url      = "http://www.percona.com/downloads/percona-toolkit/2.2.5/RPM/"
  filename = "percona-toolkit-2.2.5-2.noarch.rpm"
  checksum = "961397573b7ca9e95a1d72ae817a5a81896e94f1e04103283474cddffe116bcb"

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
  package "percona-toolkit"
end
