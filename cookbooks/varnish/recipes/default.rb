#
# Cookbook Name:: chef-varnish
# Recipe:: default
#
# Copyright 2012, Alistair Stead
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




package "varnish" do
  action :install
  not_if "rpm -q varnish"
end


template "#{node['varnish']['config_dir']}/default.vcl" do
  source "default.vcl.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :params => node['varnish']
  )
end

template node['varnish']['daemon_config'] do
  source "varnish.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :params => node['varnish']
  )
end

service "varnish" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

service "varnishlog" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end
