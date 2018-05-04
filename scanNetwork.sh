#!/bin/bash
#Variable used to move from one while loop to another
check=0

launch_scripts(){
bash ./ec2-launch.sh
bash ./software-install.sh
}

echo "Please enter the final octet of the IP address at which you would like to start the scan."
#input of final octet of ip address
read startAddress

echo "Please enter the final octet of the IP address at which you would like the scan to finish."
#input of final octet of op address
read endAddress
	#while loop to validate first user input
	while [ $check -eq 0 ]
		do
			#Checks if start address is non negative integer
			if ! [[ $startAddress =~ ^[0-9]+$ ]] ; then
				#re-read user input
        			echo "Error $startAddress is not valid, please enter a positive integer between 1 and 254" >&2;
				read startAddress
			else
				#increment check variable
				let check=$check+1
			fi
	done
	#while loop to validate second user input
	while [ $check -eq 1 ]
		do
			if ! [[ $endAddress =~ ^[0-9]+$ ]] ; then
       				echo "Error $endAddress is not valid, please enter a positive integer between 1 and 254" >&2;
				read endAddress
			else
				let check=$check+1
			fi
	done
	#validates that start address is less than end address and greater than 0
	#also validates end address is less than 255
	if [ $startAddress -gt 0 ] && [ $endAddress -le 255 ] && [ $startAddress -le $endAddress ] ; then
        			while [ $startAddress -le $endAddress ]
                        		do
                       				if  nmap -O 172.31.0.$startAddress | grep "microsoft\|Windows" > /dev/null
                         			then
                                			echo "Host 172.31.0.$startAddress is Windows"
                        			elif  nmap -O 172.31.0.$startAddress | grep "linux" > /dev/null
                         			then
                                			echo "Host 172.31.0.$startAddress is Linux"
                               	 			echo "Starting Software Sync Script"
                                			bash ./software-sync.sh 172.31.0.$startAddress
                        			else
                                			echo "No host found at 172.31.0.$startAddress"
                        			fi
                				(( startAddress++ ))

        			done
	launch_scripts
	else
		echo "Error in user inputs, please check inputs and re-run script"
	fi

