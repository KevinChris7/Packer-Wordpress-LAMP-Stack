#!/bin/bash

echo "$(date +"%d-%b-%Y-%H-%M-%S") | Installing MySQL..." | tee -a  ${INSTALL_LOG_FILE_PATH}
sudo apt install -y mysql-server #>> ${INSTALL_LOG_FILE_PATH} 2>&1      
#File Descriptors in unix stdout->1 stderr->2 
#Moving both the result in same file 


echo "$(date +"%d-%b-%Y-%H-%M-%S") | Installing expect - To automate User Input tasks"
sudo apt install -y expect

echo "$(date +"%d-%b-%Y-%H-%M-%S") | mysql secure installation"  #tee ${INSTALL_LOG_FILE_PATH}
#sudo mysql_secure_installation #>> ${INSTALL_LOG_FILE_PATH} 2>&1

SECURE_MYSQL=$(expect -c  "

set timeout 10
spawn $(which mysql_secure_installation)

expect \"Press y|Y for Yes, any other key for No:\"
send \"n\r\"

expect \"New password:\"
send \"admin\r\"

expect \"Re-enter new password:\"
send \"admin\r\"

expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"

expect EOF

")

echo ${SECURE_MYSQL}

#To log in to the MySQL server as the root user type
#EOF refers following are sql commands
sudo mysql << EOF   
use mysql
SELECT user,authentication_string,plugin,host FROM mysql.user;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin123';
FLUSH PRIVILEGES;
EOF
exit

# Creates Database,Table and User
echo "$(date +"%d-%b-%Y-%H-%M-%S") | Creating Wordpress Database..."
mysql -u root -p admin123 << EOF
use mysql
CREATE DATABASE IF NOT EXISTS wordpress;
SHOW DATABASES;
CREATE USER IF NOT EXISTS 'cjkadmin'@'localhost' IDENTIFIED BY 'cjkadmin';
SELECT user,host FROM mysql.user
CREATE TABLE IF NOT EXISTS cjk;
EOF
exit 

echo "$(date +%d-%b-%Y-%H-%M-%S") | MySQL Installation and Config Completed!!!"
