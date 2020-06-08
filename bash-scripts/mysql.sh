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
send \"admin7K1\r\"

expect \"Re-enter new password:\"
send \"admin7K1\r\"

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


echo "$(date +"%d-%b-%Y-%H-%M-%S") | MySQL Installation Completed!!!!!"