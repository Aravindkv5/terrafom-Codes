#!/bin/bash

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
# echo 
# "============================================================================
#                      Downloading Jenkins and its dependencies
# ============================================================================="
# sudo wget -O /etc/yum.repos.d/jenkins.repo \
#     https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# sudo yum upgrade
# sudo amazon-linux-extras install java-openjdk11 -y

# echo 
# "============================================================================
#                         Installing Jenkins 
# ============================================================================="
# yum install jenkins -y
# systemctl enable jenkins
# systemctl start jenkins
# systemctl status jenkins
# echo 
# "========================================================================
#                     Jenkins Installation complete
# ==============================================================================="

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

#Mounting new EBS Volume
echo "Mounting new ebs volume"
#sudo file -s /dev/sdb
#sudo mkfs -t xfs /dev/sdb
#sudo mount /dev/sdb /home/ec2-user/

#Automate EBS volume on reboot
#sudo cp /etc/fstab /etc/fstab.bak

#echo "$(blkid -o export /dev/sdb | grep ^UUID=) /home/ec2-user xfs defaults,noatime" | tee -a /etc/fstab
# Mount secondary EBS volume
echo "[-- EBS Volume Mount | START --]"
mkdir /home/aravind
mkfs -t xfs /dev/sdf
mount /dev/sdf /home/aravind
#For automation when rebooted
echo "/dev/sdf / xfs defaults 0 0" >> /etc/fstab
echo "mkfs -t xfs /dev/sdf" >> /etc/rc.local
echo "mount /dev/sdf /home/aravind" >> /etc/rc.local
chmod +x /etc/rc.d/rc.local

echo "Testing EIP Automation"
INSTANCE_ID=$(ec2-metadata --instance-id | cut -d " " -f 2);

INSTANCE_ID=$(ec2-metadata --instance-id | cut -d " " -f 2);
EIP_LIST=(eipalloc-07da69856432f7cef eipalloc-0355263fcb50412ed)
for EIP in $${EIP_LIST}; do
        echo "Checkin if EIP is free"
        ISFREE=$(aws ec2 describe-addresses --allocation-ids $EIP --query Addresses[].InstanceID --output text --region ap-south-1)
        STARTWAIT=$(date +%s)
        while [ ! -z "$ISFREE" ]; do
                if [ "$(($(date +%s) - $STARTWAIT))" -gt $MAXWAIT ]; then
                        echo "WARNING: We waited for 30 seconds, we are forcing it now."
                        ISFREE=""
                else
                        echo "checking the other EIP [$EIP]"
                        ISFREE=$(aws ec2 describe-adresses --allocation-ids $EIP --query Addresses[].InstanceID --output text --region ap-south-1)
                fi
        done
        echo "Running: aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id $EIP --allow-reassociation --region ap-south-1"
        aws ec2 associate-address --instance-id $INSTANCE_ID --allocation-id $EIP --allow-reassociation --region ap-south-1
done