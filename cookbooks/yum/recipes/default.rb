#
# = 3rd Party yum リポジトリrequire "default"

#

#
# Package install
#
# epel
cookbook_file "/var/tmp/epel-release-5-4.noarch.rpm" do
  source "epel-release-5-4.noarch.rpm"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /var/tmp/epel-release-5-4.noarch.rpm"
end

package "epel-release" do
  action :install
  source "/var/tmp/epel-release-5-4.noarch.rpm"
  provider Chef::Provider::Package::Rpm
  not_if "rpm -q epel-release"
end

# remi
cookbook_file "/var/tmp/remi-release-5.rpm" do
  source "remi-release-5.rpm"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /var/tmp/remi-release-5.rpm"
end

package "remi-release" do
  action :install
  source "/var/tmp/remi-release-5.rpm"
  provider Chef::Provider::Package::Rpm
  not_if "rpm -q remi-release"
end

#
# Configration files
#
# epel
template "/etc/yum.repos.d/epel.repo" do
  source "epel.repo.el5.erb"
  owner "root"
  group "root"
  mode "0644"
end

# remi
template "/etc/yum.repos.d/remi.repo" do
  source "remi.repo.el5.erb"
  owner "root"
  group "root"
  mode "0644"
end
