#
# = httpd
#

#
# install from source
#

# cd /usr/src/
# tar -zxvf httpd-2.0.64
# cd ./httpd-2.0.64
# ./configure --prefix=/usr/local/
# make
# make install

cookbook_file "/tmp/httpd-2.0.64.tar.gz" do
  source "httpd-2.0.64.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/httpd-2.0.64.tar.gz"
end


directory '/usr/local/apache2' do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

script "install httpd-2.0.64" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxvf httpd-2.0.64.tar.gz
    cd ./httpd-2.0.64
    ./configure --prefix=/usr/local/apache2/
    make
    make install
  EOH
  not_if do
    File.exists?("/usr/local/apache2/bin/httpd")
  end
end

template "/etc/init.d/httpd" do
  source "conf/httpd.erb"
  owner "root"
  group "root"
  mode "0755"
end
#
# Configration files
#
# httpd.conf
template "/usr/local/apache2/conf/httpd.conf " do
  source "conf/httpd.conf.erb"
  owner "root"
  group "root"
  mode "0664"
end

service "httpd" do
  service_name "httpd"
  supports :status => true, :restart => true, :reload => true
  notifies :restart, "service[httpd]", :immediately
end


execute "chkconfig httpd on" do
  command "chkconfig httpd on"
end
