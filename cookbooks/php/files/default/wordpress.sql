CREATE DATABASE IF NOT EXISTS `website` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON website.* to 'website'@'localhost' identified by 'website12034';
update mysql.user set password=OLD_PASSWORD('website12034') where user = 'website';
FLUSH PRIVILEGES;



