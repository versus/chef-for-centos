#
# = PHP

package "zlib" do
  action :install
  not_if "rpm -q zlib"
end

package "zlib-devel" do
  action :install
  not_if "rpm -q zlib-devel"
end

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
    ./configure --with-mysql --with-zlib --with-apxs2=/usr/local/apache2/bin/apxs 
    make
    make install
  EOH
  not_if do
    File.exists?("/usr/local/bin/php")
  end
end

cookbook_file "/tmp/memcache-2.2.7.tgz" do
  source "memcache-2.2.7.tgz"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/memcache-2.2.7.tgz"
end

script "install php-memcache" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxvf memcache-2.2.7.tgz
  cd ./memcache-2.2.7
  /usr/local/bin/phpize
  ./configure
  make
  make install
  EOH
  not_if do
    File.exists?("/usr/local/lib/php/extensions/no-debug-non-zts-20020429/memcache.so")
  end
end

cookbook_file "/tmp/suphp-0.7.2.tar.gz" do
  source "suphp-0.7.2.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/suphp-0.7.2.tar.gz"
end

script "install suphp" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxvf suphp-0.7.2.tar.gz
  cd ./suphp-0.7.2
  autoreconf -vif
  ./configure --with-apxs=/usr/local/apache2/bin/apxs  --sysconfdir=/etc
  make
  make install
  EOH
  not_if do
    File.exists?("/usr/local/apache2/modules/mod_suphp.so")
  end
end

cookbook_file "/tmp/wordpress-3.1.4.tar.gz" do
  source "wordpress-3.1.4.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/wordpress-3.1.4.tar.gz"
end

directory "/var/www/websitemigrations.com" do
  owner "www-data"
  group "www-data"
  mode "0755"
  action :create
end

cookbook_file "/tmp/wordpress.sql" do
  source "wordpress.sql"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/wordpress.sql"
end

script "install wordpress" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  tar -zxvf wordpress-3.1.4.tar.gz
  cp -r  ./wordpress/* /var/www/websitemigrations.com/
  chown -R www-data:www-data /var/www/websitemigrations.com
  rm -rf ./wordpress
  /usr/bin/mysql -u root -ptea54to1n < wordpress.sql
  EOH
  not_if do
    File.exists?("/var/www/websitemigrations.com/index.php")
  end
end

cookbook_file "/tmp/w3-total-cache.0.9.1.3.zip" do
  source "w3-total-cache.0.9.1.3.zip"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /tmp/w3-total-cache.0.9.1.3.zip"
end 

script "install wordpress W3 plugin" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  unzip w3-total-cache.0.9.1.3.zip
  cp -r ./w3-total-cache  /var/www/websitemigrations.com/wp-content/plugins
  chown -R www-data:www-data /var/www/websitemigrations.com
  EOH
  not_if do
    File.exists?("/var/www/websitemigrations.com/wp-content/plugins/w3-total-cache/w3-total-cache.php")
  end
end
#
# Configration files
#

template "/etc/suphp.conf" do
  source "suphp.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /etc/suphp.conf"
end

template "/usr/local/lib/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  not_if "test -e /usr/local/lib/php.ini"
end


