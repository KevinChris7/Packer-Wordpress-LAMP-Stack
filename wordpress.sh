#!/bin/bash

# Creates Database,Table and User
echo "$(date +"%d-%b-%Y-%H-%M-%S") | Creating Wordpress Database..."

LOGIN_MYSQL=$(expect -c  "

set timeout 3
spawn $(sudo mysql -u root -p)
expect \"Enter password:\"
send \"admin123K\r\"

expect EOF

")

echo ${LOGIN_MYSQL}


 << EOF
use mysql
CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
SHOW DATABASES;
CREATE USER IF NOT EXISTS 'cjkadmin'@'localhost' IDENTIFIED BY 'w0rdPress7q!';
GRANT ALL ON wordpress.* TO 'cjkadmin'@'localhost' IDENTIFIED BY 'w0rdPress7q!';
FLUSH PRIVILEGES;
SELECT user,host FROM mysql.user
CREATE TABLE IF NOT EXISTS cjk;
EOF
exit 

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Downloading Wordpress...."
cd /opt/wordpress
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

touch /opt/wordpress/.htaccess
chmod 660 /tmp/wordpress/.htaccess

cp /opt/wordpress/wp-config-sample.php /opt/wordpress/wp-config.php

mkdir /opt/wordpress/wp-content/upgrade #To avoid wordpress run into permission issues when upgrade

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Moving Wordpress Directory to Document Root...."
sudo cp -a /opt/wordpress/. /var/www/html

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Configuring Wordpress Directory..."
sudo chown -R ubuntu:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+s {} \;
sudo chmod g+w /var/www/html/wp-content
sudo chmod -R g+w /var/www/html/wp-content/themes
sudo chmod -R g+w /var/www/html/wp-content/plugins

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Setting up the WordPress Configuration File..."
curl -s https://api.wordpress.org/secret-key/1.1/salt/
