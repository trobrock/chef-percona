name             "percona"
maintainer       "Outright.com"
maintainer_email "trae@outright.com"
license          "All rights reserved"
description      "Installs/Configures percona"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ rhel centos debian ubuntu }.each do |os|
  supports os
end

attribute "percona/version",
  :description => "Version of Percona MySQL to install",
  :type        => "string",
  :required    => "required",
  :default     => "5.1"
