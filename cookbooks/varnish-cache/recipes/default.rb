#
# Cookbook Name:: varnish-cache
# Recipe:: default
#
# Copyright (C) 2013 Valentin Nastenko
# 
# All rights reserved - Do Not Redistribute
#



#rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release-3.0-1.noarch.rpm

execute "install varnish yum repo" do
  command "rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el5/noarch/varnish-release-3.0-1.noarch.rpm"
  creates "/etc/yum.repos.d/varnish.repo"
  action :run
  notifies :run, "execute[yum_clean_all]", :immediately
end

execute "yum_clean_all" do
  command "yum clean all"
  action :nothing
end

package "varnish" do
  action :install
  not_if "rpm -q varnish"
end
