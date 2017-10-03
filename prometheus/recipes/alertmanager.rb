#
# Cookbook:: prometheus_wrapper
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

remote_file 'Prometheus_download' do
  path '/tmp/alertmanager-0.9.1.linux-amd64.tar.gz'
  source 'https://github.com/prometheus/alertmanager/releases/download/v0.9.1/alertmanager-0.9.1.linux-amd64.tar.gz'
  mode '0755'
  action :create
end


execute 'untar alertmanager' do
  command 'tar -xzf /tmp/alertmanager-0.9.1.linux-amd64.tar.gz -C /opt; ln -s /opt/alertmanager-0.9.1.linux-amd64 /opt/alertmanager'
  not_if { File.exists?("/opt/alertmanager") }
end 

cookbook_file '/etc/init.d/alertmanager' do
  source 'alertmanager-initd-ubuntu'
  mode '0755'
  action :create
  notifies :restart, "service[alertmanager]", :delayed
end

cookbook_file '/opt/alertmanager/alertmanager.yml' do
  source 'alertmanager.yml'
  mode '0755'
  action :create
  notifies :restart, "service[alertmanager]", :delayed
end

service "alertmanager" do
  action :start
end