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
