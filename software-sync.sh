#!/bin/bash
sleep 1
 
ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@$1 'rpm -qa > installed-software.log'
echo "Software sync on $1 successful"





