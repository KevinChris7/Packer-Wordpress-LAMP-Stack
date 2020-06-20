# **Packer-Wordpress-LAMP-Stack**

## **About Packer**

Packer is an open source tool for building machine images for various platforms from a single configuration.
Packer works well with Infrastructure management tool like Terraform and Configuration management tools like ansible,chef and Puppet.
Machine Image refers to pre-configured OS and pre-installed Softwares

## **About Project**

1.Install the Packer.

2.Used amazon-ebs as Builder with various provisioners.

3.Create scripts for install and configuration for LAMP Stack

4.Download and Install the Wordpress including setup

5.Build the AMI and Launch the Instance with it

## **System requirements**

This version of packages and files was last tested on:

Ubuntu 20.04

Python 3.8

Packer 1.3.4

## **Infrastructure**

Ubuntu WSL - AWS Cloud - RHEL7

## **Development Environment**

Ubuntu WSL

## **Usage**

1.Install Packer on Ubuntu machine

> sudo apt install packer

2.Clone this repository

> git clone https://github.com/KevinChris7/Packer-Wordpress-LAMP-Stack.git

3.Add the AWS access credentials as Environment Variables

> export AWS_ACCESS_KEY_ID="YOUR ACCESS KEY HERE"

> export AWS_SECRET_ACCESS_KEY="YOUR SECRET ACCESS KEY HERE"

4.Add the JSON file for building the machine images
> wordpress.json

5.Add the Script Files for LAMP Stack and Wordpress

> apache.sh
> firewall.sh
> mysql.sh
> php.sh
> wordpress.sh

6.To Validate the packer template file

> packer validate wordpress.json

7.To Build the packer template file

> packer build wordpress.json

## **Project Insider**

- **Builder**: amazon-ebs

- **Provisioner**: shell

- **Source AMI**: RHEL Instance AMI


