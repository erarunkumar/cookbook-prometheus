name             'prometheus_wrapper'
maintainer       'shiva'
maintainer_email 'shiva@gmail.com'
license          'Apache 2.0'
description      'Prometheus'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'
source_url 'https://github.com/elijah/chef-prometheus'
issues_url 'https://github.com/elijah/chef-prometheus/issues'
chef_version '>= 12.15.25' if respond_to?(:chef_version)

%w(ubuntu debian centos redhat fedora).each do |os|
  supports os
end

depends 'prometheus' # any higher requires chef 12
