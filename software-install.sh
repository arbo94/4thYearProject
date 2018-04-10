#!/bin/bash
sleep 1
echo Please input the public IP V4 address of the Linux 1 instance

read address1 

echo Please input the public IP V4 address of the Linux 2 instance

read address2
ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@$address1 'sudo yum -y install $(cat ./installed-software.log)'
 
ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@$address2 'sudo yum -y install $(cat ./installed-software.log)'





