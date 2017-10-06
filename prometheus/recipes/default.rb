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

cookbook_file '/tmp/prometheus-1.7.2.linux-amd64.tar.gz' do
  source 'prometheus-1.7.2.linux-amd64.tar.gz'
  mode '0755'
  action :create
end

execute 'untar prometheus' do
  command 'tar -xzf /tmp/prometheus-1.7.2.linux-amd64.tar.gz -C /opt; ln -s /opt/prometheus-1.7.2.linux-amd64 /opt/prometheus'
  #cwd '/root/Downloads/'
  not_if { File.exists?("/opt/prometheus") }
end 

cookbook_file '/etc/init.d/prometheus' do
  source 'prometheus-initd-ubuntu'
  mode '0755'
  action :create
  notifies :restart, "service[prometheus]", :delayed
end

cookbook_file '/opt/prometheus/prometheus.yml' do
  source 'prometheus.yml'
  mode '0755'
  action :create
  notifies :restart, "service[prometheus]", :delayed
end

cookbook_file '/opt/prometheus/alert.rules' do
  source 'alert.rules'
  mode '0755'
  action :create
end


service "prometheus" do
  action :start

