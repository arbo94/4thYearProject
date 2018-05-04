
#!/bin/bash
sleep 1
linux1on="1 host up"

if nmap -sP 172.31.0.10 | grep "$linux1on" > /dev/null
	then
	   echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Linux 1 host is online. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	else
		echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Linux 1 host is offline. Please switch on blue Linux 1. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	fi

#!/bin/bash
sleep 1
linux2on="1 host up"
if nmap -sP 172.31.0.11 | grep "$linux2on" > /dev/null
	then
	   echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Linux 2 host is online. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	else
		echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Linux 2 host is offline. Please switch on blue Linux 2. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	fi



#!/bin/bash
sleep 1
windows1on="1 host up"
if nmap -sP 172.31.0.19 | grep "$windows1on" > /dev/null
	then
	   echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Windows 1 host is online. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	else
		echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Windows 1 host is offline. Please switch on blue Windows 1. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	fi

#!/bin/bash
sleep 1
windows2on="1 host up"
if nmap -sP 172.31.0.20 | grep "$windows2on" > /dev/null
	then
	   echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Windows 2 host is online. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	else
		echo "$(date '+%d-%m-%Y %H:%M:%S')               Blue Windows 2 host is offline. Please switch on blue Windows 2. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
	fi

#!/bin/bash
sleep 1
linux1="$(aws ec2 describe-instances | grep "172.31.0.10")"

if [[ -z "$linux1"  ]]
then
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Linux 1 host does not exist on AWS. The Script will launch it in the eu-west-01 region. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
  else
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Linux 1 host already exists on AWS. This will not be re-launched. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi

#!/bin/bash
sleep 1
linux2="$(aws ec2 describe-instances | grep "172.31.0.11")"

if [[ -z "$linux2"  ]]
then
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Linux 2 host does not exist on AWS. The Script will launch it in the eu-west-01 region. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
  else
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Linux 2 host already exists on AWS. This will not be re-launched " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi

#!/bin/bash
sleep 1
windows1="$(aws ec2 describe-instances | grep "172.31.0.19")"

if [[ -z "$windows1"  ]]
then
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Windows 1 host does not exist on AWS. The Script will launch it in the eu-west-01 region. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
  else
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Windows 1 host already exists on AWS. This will not be re-launched. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi

#!/bin/bash
sleep 1
windows2="$(aws ec2 describe-instances | grep "172.31.0.20")"

if [[ -z "$windows2"  ]]
then
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Windows 2 host does not exist on AWS. The Script will launch it in the eu-west-01 region. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
  else
  echo "$(date '+%d-%m-%Y %H:%M:%S')               Windows 2 host already exists on AWS. This will not be re-launched. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi



#############################################################################################################################

##### Part3 - NMAP Scan.

#!/bin/bash
sleep 1
alivehosts1="linux"
if nmap -sT -O 172.31.0.10 | grep "$alivehosts1" > /dev/null
 then
aws ec2 run-instances --image-id ami-d834aba1 --count 1 --instance-type t2.micro --key-name MyKeyPair --iam-instance-profile Name=S3-access-IAM --security-group-ids sg-879519fd --subnet-id subnet-dcdafebb --private-ip-address 172.31.0.10 --associate-public-ip-address --user-data file://s3-linux1.txt > machines.json
 else
     	echo "$(date '+%d-%m-%Y %H:%M:%S')               Host 1 is not available " | tee -a /root"$(date '+%d%m%Y') AWS.log"
fi



#!/bin/bash
sleep 1
alivehosts2="linux"
if nmap -sT -O 172.31.0.11 | grep "$alivehosts2" > /dev/null
 then
aws ec2 run-instances --image-id ami-d834aba1 --count 1 --instance-type t2.micro --key-name MyKeyPair --iam-instance-profile Name=S3-access-IAM --security-group-ids sg-879519fd --subnet-id subnet-dcdafebb --private-ip-address 172.31.0.11 --associate-public-ip-address --user-data file://s3-linux2.txt >> machines.json
 else
     	echo "$(date '+%d-%m-%Y %H:%M:%S')               Host 2 is not available " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi




#!/bin/bash
sleep 1
alivehosts3="microsoft\|Windows"
if nmap -sT -O 172.31.0.19 | grep "$alivehosts3" > /dev/null

 then
aws ec2 run-instances --image-id ami-bb1168c2 --count 1 --instance-type t2.micro --key-name MyKeyPair --iam-instance-profile Name=S3-access-IAM --security-group-ids sg-879519fd --subnet-id subnet-dcdafebb --private-ip-address 172.31.0.19 --associate-public-ip-address --user-data file://s3-windows1.txt >> machines.json
 else
     	echo "$(date '+%d-%m-%Y %H:%M:%S')              Host 3 is not available " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi



#!/bin/bash
sleep 1
alivehosts4="microsoft\|Windows"
if nmap -sT -O 172.31.0.20 | grep "$alivehosts4" > /dev/null
 then
aws ec2 run-instances --image-id ami-bb1168c2 --count 1 --instance-type t2.micro --key-name MyKeyPair --iam-instance-profile Name=S3-access-IAM --security-group-ids sg-879519fd --subnet-id subnet-dcdafebb --private-ip-address 172.31.0.20 --associate-public-ip-address --user-data file://s3-windows2.txt >> machines.json
 else
     	echo "$(date '+%d-%m-%Y %H:%M:%S')               Host 4 is not available " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi


############################################################################################################################

#### Part4 - Check if the script worked

#!/bin/bash
sleep 30
fin="172.31.0.10\|172.31.0.11\|172.31.0.19\|172.31.0.20"
if aws ec2 describe-instances | grep "$fin" > /dev/null
	then
		echo "$(date '+%d-%m-%Y %H:%M:%S')               The script was completed successfully. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
		aws s3 cp /root/machines.json s3://bucket-for-backups2/JSON/ > /dev/null
		echo "JSON file uploaded to bucket-for-backups2/JSON/"
	else
		echo "$(date '+%d-%m-%Y %H:%M:%S')               The script was not completed. " | tee -a /root/"$(date '+%d%m%Y') AWS.log"
fi
