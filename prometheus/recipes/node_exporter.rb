#
# Cookbook:: prometheus_wrapper
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

#remote_file 'Prometheus_download' do
#  path '/tmp/prometheus-1.7.2.linux-amd64.tar.gz'
#  source 'https://github.com/prometheus/prometheus/releases/download/v1.7.2/prometheus-1.7.2.linux-amd64.tar.gz'
#  mode '0755'
#  action :create
#end

cookbook_file '/tmp/node_exporter-0.15.0.linux-amd64.tar.gz' do
  source 'node_exporter-0.15.0.linux-amd64.tar.gz'
  mode '0755'
  action :create
end

execute 'untar prometheus' do
  command 'tar -xzf /tmp/node_exporter-0.15.0.linux-amd64.tar.gz -C /opt; ln -s /opt/node_exporter-0.15.0.linux-amd64 /opt/node_exporter'
  #cwd '/root/Downloads/'
  not_if { File.exists?("/opt/node_exporter") }
end 

link '/usr/bin/node_exporter' do
  to '/opt/node_exporter/node_exporter'
end


cookbook_file '/etc/init.d/node_exporter' do
  source 'node_exporter-initd-ubuntu'
  mode '0755'
  action :create
  notifies :restart, "service[node_exporter]", :delayed
end


service "node_exporter" do
  action :start
end

