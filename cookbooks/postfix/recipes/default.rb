#
# postfix and dovecot
#

#
# Configuration files
#

package "dovecot" do
  action :install
  not_if "rpm -q dovecot"
end

package "postfix" do
  action :install
  not_if "rpm -q postfix"
end


execute "chkconfig postfix on" do
  command "chkconfig postfix on"
end

execute "chkconfig dovecot on" do
  command "chkconfig dovecot on"
end

service "dovecot" do
  action :start
  provider Chef::Provider::Service::Init
end

service "postfix" do
  action :start
  provider Chef::Provider::Service::Init
end

