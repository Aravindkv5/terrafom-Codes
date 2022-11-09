#!/usr/bin/env bash

#This script is to install some packages in the new linux servers

# Updating the yum reository
echo
"=============================================================================
                    Updating the yum repository
=============================================================================="
sudo yum update –y
echo 
"=============================================================================
                    Yum Repo update completed
============================================================================="

# Installing Jenkins
echo 
"============================================================================
                     Downloading Jenkins and its dependencies
============================================================================="
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo amazon-linux-extras install java-openjdk11 -y

echo 
"============================================================================
                        Installing Jenkins 
============================================================================="
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins
echo 
"========================================================================
                    Jenkins Installation complete
==============================================================================="

# Installing Python


# Installing Terraform 
echo 
"========================================================================
                    Installing Terraform 
=============================================================================="
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
echo 
"===============================================================================
                Terraform Installation Complete
================================================================================"


#Installing terragrunt 
echo "
==================================================================================
                    Downloading Terragrunt
=================================================================================="
cd /home/ec2-user
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.39.2/terragrunt_linux_amd64
sudo mv terragrunt_linux_amd64  terragrunt
echo "===============================================================================
                    Changing Permissions
====================================================================================="
sudo chmod u+x terragrunt
echo "===============================================================================
                    Moving terragrnt to /usr/loacl/bin/terrragrunt
===================================================================================="
sudo mv terragrunt /usr/local/bin/terragrunt

#Install git
echo "==============================================================================
                    Installing Terragrunt
===================================================================================="
yum install git -y
echo 
"==============================================================================
                    Git installation complete
===================================================================================="


#script for httpd - to test the load balancer we can use this 
echo "httpd installation and hostname script"
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "Hi my private/hostname is $(hostname -f)" > /var/www/html/index.html
systemctl restart httpd

