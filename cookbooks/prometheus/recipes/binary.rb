#
# Cookbook Name:: prometheus
# Recipe:: binary
#
# Author: Kristian Jarvenpaa <kristian.jarvenpaa@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'ark::default'

%w(curl tar bzip2).each do |pkg|
  package pkg
end

dir_name = ::File.basename(node['prometheus']['dir'])
dir_path = ::File.dirname(node['prometheus']['dir'])

#ark dir_name do
#  url node['prometheus']['binary_url']
#  checksum node['prometheus']['checksum']
#  version node['prometheus']['version']
#  prefix_root Chef::Config['file_cache_path']
#  path dir_path
#  owner node['prometheus']['user']
#  group node['prometheus']['group']
#  extension node['prometheus']['file_extension'] unless node['prometheus']['file_extension'].empty?
#  action :put
#end

#remote_file '/opt/prometheus.tar.gz' do
#    source node['prometheus']['binary_url']
#    checksum node['prometheus']['checksum']
#    owner node['prometheus']['user']
#    action :create_if_missing
#end

execute "download prometheus-#{node['prometheus']['version']}.linux-amd64.tar.gz" do
    command "wget -nc #{node['prometheus']['binary_url']}"
    cwd '/opt'
    not_if { File.exists?("/opt/prometheus-#{node['prometheus']['version']}.linux-amd64.tar.gz") }
end


execute "untar prometheus-#{node['prometheus']['version']}.linux-amd64.tar.gz" do
    command "tar -xvf prometheus-#{node['prometheus']['version']}.linux-amd64.tar.gz -C prometheus/ --strip-components=1"
    cwd '/opt'
    not_if { File.exists?("/opt/prometheus/prometheus") }
end
