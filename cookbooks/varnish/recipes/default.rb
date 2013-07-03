#
# Cookbook Name:: varnish-cache
# Recipe:: default
#
# Copyright (C) 2013 Valentin Nastenko
# 
# All rights reserved - Do Not Redistribute
#



package "varnish" do
  action :install
  not_if "rpm -q varnish"
end

#template "/etc/varnish/default.vcl" do
#  source "default.vcl.erb"
#  owner "root"
#  group "root"
#  mode "0664"
#end

