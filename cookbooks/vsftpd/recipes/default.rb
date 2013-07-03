#
# Cookbook Name:: vsftpd
# Recipe:: default
#
# Copyright (C) 2013 Valentyn Nastenko
# 
# All rights reserved - Do Not Redistribute
#

package "vsftpd" do
  action :install
  not_if "rpm -q vsftpd"
end

