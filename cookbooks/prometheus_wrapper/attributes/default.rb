#
# Cookbook Name:: prometheus_wrapper
# Attributes:: default
#

default['prometheus_wrapper']['client_servers']	= [ 
  {
    'server_name' => 'optipng',
    'target' => '192.168.1.2', 
    'scrape_interval' => '0.7.5'
  },	