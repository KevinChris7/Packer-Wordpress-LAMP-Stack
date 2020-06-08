#!/bin/bash

#Enabling UFW Firewall
sudo ufw app list
sudo ufw allow OpenSSH
sudo ufw enable -y
sudo ufw status

#Adjust Firewall to allow traffic
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
