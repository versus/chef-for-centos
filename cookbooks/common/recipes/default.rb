#
# = Linux common packages
#

#
# Package install
#

package "wget" do
  action :install
  not_if "rpm -q wget"
end

package "bind-utils" do
  action :install
  not_if "rpm -q bind-utils"
end

package "traceroute" do
  action :install
  not_if "rpm -q traceroute"
end

package "man" do
  action :install
  not_if "rpm -q man"
end

package "crontabs" do
  action :install
  not_if "rpm -q crontabs"
end

package "gcc" do
  action :install
  not_if "rpm -q gcc"
end

package "make" do
  action :install
  not_if "rpm -q make"
end

package "vim-minimal" do
  action :install
  not_if "rpm -q vim-minimal"
end

package "gettext" do
  action :install
  not_if "rpm -q gettext"
end

package "rpm-build" do
  action :install
  not_if "rpm -q rpm-build"
end

package "mc" do
  action :install
  not_if "rpm -q mc"
end

package "tcpdump" do
  action :install
  not_if "rpm -q tcpdump"
end

package "flex" do
  action :install
  not_if "rpm -q flex"
end


package "tmux" do
  action :install
  not_if "rpm -q tmux"
end

package "memcached" do
  action :install
  not_if "rpm -q memcached"
end

service "memcached" do
  service_name "memcached"
  supports :status => true, :restart => true, :reload => true
  notifies :start, "service[memcached]", :immediately
end
#
# chkconfig
#
execute "chkconfig crond on" do
  command "chkconfig crond on"
end

execute "chkconfig memcached on" do
  command "chkconfig memcached on"
end