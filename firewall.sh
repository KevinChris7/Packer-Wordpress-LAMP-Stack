#!/bin/bash

#Enabling UFW Firewall
ufw app list
ufw allow OpenSSH
ufw enable -y
ufw status

#Adjust Firewall to allow traffic
sudo ufw app info "Apache Full"
sudo ufw allow in "Apache Full"
