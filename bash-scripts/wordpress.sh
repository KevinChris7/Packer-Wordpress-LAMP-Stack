#!/bin/bash

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Creating Wordpress Database..."

CREATE_DB="create database $WORDPRESS_DB_NAME;
GRANT ALL PRIVILEGES ON wordpress.* TO '$MYSQL_RT_USERNAME'@'localhost' IDENTIFIED BY '$MYSQL_RT_PASSWORD';
FLUSH PRIVILEGES;
SHOW DATABASES;
CREATE USER IF NOT EXISTS '$ADMIN_USERNAME'@'localhost' IDENTIFIED BY '$ADMIN_PASSWORD';
GRANT ALL ON wordpress.* TO '$ADMIN_USERNAME'@'localhost' IDENTIFIED BY '$ADMIN_PASSWORD';
FLUSH PRIVILEGES;
SELECT user,host FROM mysql.user;
CREATE TABLE IF NOT EXISTS $TABLE_NAME;"
mysql -u $MYSQL_RT_USERNAME --password=$MYSQL_RT_PASSWORD -e "$CREATE_DB"


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

#Manual setup of DB details in config file
#nano wp-config.php
# define('DB_NAME', 'wordpress');
# define('DB_USER', 'wordpressuser');
# define('DB_PASSWORD', 'password');

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Copying Files to Document Root..."
sudo rsync -avP ~/wordpress/ /var/www/html/
cd /var/www/html
sudo chown -R cjkadmin:www-data *
mkdir /var/www/html/wp-content/uploads
sudo chown -R :www-data /var/www/html/wp-content/uploads

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Wordpress Installation and Setup Completed..."
