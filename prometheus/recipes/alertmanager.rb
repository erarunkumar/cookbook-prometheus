#
# Cookbook:: prometheus
# Recipe:: alertmanager
#
# Copyright:: 2017, The Authors, All Rights Reserved.

cookbook_file '/tmp/alertmanager-0.9.1.linux-amd64.tar.gz' do
  source 'alertmanager-0.9.1.linux-amd64.tar.gz'
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

file '/opt/alertmanager/alertmanager.yml' do
  action :delete
  only_if { File.exist? '/opt/alertmanager/alertmanager.yml' }
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
