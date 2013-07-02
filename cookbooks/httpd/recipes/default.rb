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


directory '/opt/apache2' do
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
    ./configure --prefix=/opt/apache2/
    make
    make install
  EOH
  not_if do
    File.exists?("/opt/apache2/bin/httpd")
  end
end

#
# Configration files
#
# httpd.conf
template "/etc/httpd/conf/httpd.conf" do
  source "conf/httpd.conf.erb"
  owner "root"
  group "root"
  mode "0664"
#  notifies :restart, "service[httpd]"
end
