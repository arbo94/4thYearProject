#!/bin/bash
sleep 1
check=0
address1=0
echo Please input the public IP V4 address of the Linux 1 instance

read address1

echo Please input the public IP V4 address of the Linux 2 instance

read address2

	while [ $check -eq 0 ]
		do
		if [ `echo $address1 | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'` ] ; then
			ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@$address1 'sudo yum -y install $(cat ./installed-software.log)'
			let check=$check+1
		else
			echo "Error $address1 not in correct format please use format XXX.XXX.XXX.XXX" >&2;
			read address1
		fi
	done
	while [ $check -eq 1 ]
		do
		if [ `echo $address2 | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'` ] ; then
			ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@$address2 'sudo yum -y install $(cat ./installed-software.log)' 
			let check=$check+1
		else
			echo "Error $address2 not in correct format please use format XXX.XXX.XXX.XXX" >&2;
			read address2
		fi
	done



