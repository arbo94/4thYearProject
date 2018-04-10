#!/bin/bash

echo "Please enter the final octet of the IP address at which you would like to start the scan." 

read startAddress

echo "Please enter the final octet of the IP address at which you would like the scan to finish."

read endAddress

if [ $startAddress -gt 0 ] && [ $endAddress -le 255 ]; then
	while [ $startAddress -le $endAddress ]
			do
			if  nmap -O 172.31.0.$startAddress | grep "microsoft\|Windows" > /dev/null  
			 then
				echo "Host 172.31.0.$startAddress is Windows"
			elif  nmap -O 172.31.0.$startAddress | grep "linux" > /dev/null  
			 then
				echo "Host 172.31.0.$startAddress is Linux"
				echo "Starting software Sync Script"
				sh ./software-sync.sh 172.31.0.$startAddress
			else
				echo "No host found at 172.31.0.$startAddress"
			fi
		(( startAddress++ ))
	done
fi
