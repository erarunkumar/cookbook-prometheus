#
# Cookbook:: prometheus_wrapper
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

remote_file 'Prometheus_download' do
  path '/tmp/prometheus-1.7.2.linux-amd64.tar.gz'
  source 'https://github.com/prometheus/prometheus/releases/download/v1.7.2/prometheus-1.7.2.linux-amd64.tar.gz'
  mode '0755'
  action :create
end


execute 'untar prometheus' do
  command 'tar -xzf /tmp/prometheus-1.7.2.linux-amd64.tar.gz -C /opt; ln -s /opt/prometheus-1.7.2.linux-amd64 /opt/prometheus'
  #cwd '/root/Downloads/'
  not_if { File.exists?("/opt/prometheus") }
end 

cookbook_file '/etc/init/promotheus.conf' do
  source 'promotheus.conf'
  mode '0755'
  action :create
end

service "promotheus" do
  action :restart
end

