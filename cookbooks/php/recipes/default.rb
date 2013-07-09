#
# = PHP
#

#
#  install from source
#
# cd /usr/src/
# tar -zxvf php-4.3.5RC4.tar.gz
# cd ./php-4.3.5RC4
# ./configure --with-mysql --with-apxs2=/usr/local/apache2/bin/apxs
# make
# make install

cookbook_file "/tmp/php-4.3.5RC4.tar.gz" do
  source "php-4.3.5RC4.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/php-4.3.5RC4.tar.gz"
end

script "install php-4.3" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxvf php-4.3.5RC4.tar.gz
    cd ./php-4.3.5RC4
    make clean
    ./configure --with-mysql --with-apxs2=/usr/local/apache2/bin/apxs 
    make
    make install
  EOH
  not_if do
    File.exists?("/usr/local/bin/php")
  end
end

cookbook_file "/tmp/memcache-3.0.8.tgz" do
  source "memcache-3.0.8.tgz"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/memcache-3.0.8.tgz"
end

script "install php-memcache" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxvf memcache-3.0.8.tgz
  cd ./memcache-3.0.8
  /usr/local/bin/phpize
  ./configure
  make
  make install
  EOH
end


#
# Configration files
#
#template "/etc/php.ini" do
#  source "php.ini.erb"
#  owner "root"
#  group "root"
#  mode "0644"
#  notifies :restart, "service[httpd]"
#end


