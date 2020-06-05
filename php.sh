#!/bin/bash

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Installing PHP...."
sudo apt -y install php libapache2-mod-php php-mysql

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Apache looks for index.php"
#sudo nano /etc/apache2/mods-enabled/dir.conf

#DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
$sed 's/index.php/index.php_old' /etc/apache2/mods-enabled/dir.conf
$sed 's/index.html/index.php' /etc/apache2/mods-enabled/dir.conf

cat > dir.conf

apt install php-cli
