#!/bin/bash ### Execute Sync to AWS Bucket
sleep 1

# Execute Linux1 Sync to AWS bucket-for-backups2
ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@172.31.0.10 aws s3 sync /home/ec2-user/ s3://bucket-for-backups2/linux1/

# Execute Linux2 Sync to AWS bucket-for-backups2
ssh -i /root/keys/MyKeyPair-Site1.pem ec2-user@172.31.0.11 aws s3 sync /home/ec2-user/ s3://bucket-for-backups2/linux2/

# Execute Win1 and Win2 Sync to AWS bucket-for-backups2
pwsh /root/win1-sync-to-bucket.ps1
pwsh /root/win2-sync-to-bucket.ps1
return 1



