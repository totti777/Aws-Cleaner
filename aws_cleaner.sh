#!/bin/bash

# Variables
# REGION=""  # Always in credentials file
PROFILES=$(cat ~/.aws/credentials | grep -F '[' | sed -e 's/\[//' -e 's/\]//')
NUMPROFILES=`echo "$PROFILES" | awk '{print NR, $NF}'`
# Mostra de perfils disponibles i executar un
echo "The available profiles are: "
echo "$NUMPROFILES"
read -p "Which profile would you execute   " NUMPROFILE
PROFILE=`echo "$PROFILES" | sed -n "$NUMPROFILE"p`

# Set OWNER
OWNER=`aws iam get-user --profile $PROFILE |& sed '/^\s*$/d' | grep -o -P '(?<=iam::).*(?=:user)'`
echo "My owner ID is: $OWNER"

# The default value for PS3 is set to #?.
# Change it i.e. Set PS3 prompt
PS3="Enter the option would you do : "
# set option list
options=("Delete AMI and all Snapshots older than X" "Delete only orphan Snapshots older than X" "Delete unused Volumes" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Delete AMI and all Snapshots older than X")
   			read -p "How many older AMI and Snapshots would you remove:  " DAYS
			echo "--------------"
			echo "Delete AMI and all Snapshots older than $DAYS days on `date +%Y-%m-%d`"
			echo "--------------"
			# Set DATE variable
			DATE=$(date +%Y-%m-%d --date "$DAYS days ago")
			DATE=$(echo \`$DATE\`)
			echo $DATE
			# Deregister AMI'S
			echo "Delete AMI older than $DAYS days on `date +%Y-%m-%d`" | tee -a ~/Aws/aws_delete_ami.log
			aws ec2 describe-images --profile $PROFILE --query "Images[?CreationDate <= $DATE][ImageId]" --owners $OWNER --output text | xargs -n 1 -I % sh -c "echo % | tee -a ~/Aws/aws_delete_ami.log; aws ec2 deregister-image --profile $PROFILE --image-id %"
			# Delete all  Snapshots
			echo "Delete Snapshots older than $DAYS days on `date +%Y-%m-%d`" | tee -a ~/Aws/aws_delete_snapshots.log
			aws ec2 describe-snapshots --profile $PROFILE --query "Snapshots[?StartTime <= $DATE].{id:SnapshotId}" --owner-ids $OWNER --output text |  xargs -n 1 -I % sh -c "echo % | tee -a ~/Aws/aws_delete_snapshots.log; aws ec2 delete-snapshot --profile $PROFILE --snapshot-id %"
			;;
		"Delete only orphan Snapshots older than X")
   			read -p "How many older orphan Snapshots would you remove:  " DAYS
			echo "--------------"		
			echo "You chose Delete only orphan Snapshots older than $DAYS days" 
			echo "--------------"
			# Set DATE variable
			DATE=$(date +%Y-%m-%d --date "$DAYS days ago")
			DATE=$(echo \`$DATE\`)
			# Set all Snapshots for AMI'S	
			SNAPAMI=$(aws ec2 describe-images --profile $PROFILE --query "Images[?CreationDate <= $DATE].BlockDeviceMappings[*].Ebs.SnapshotId" --owners $OWNER --output json | sort -u | grep -o -P '(?<=").*(?=")')
			# Set all AMI'S
			ALLAMI=$(aws ec2 describe-images --profile $PROFILE --query "Images[?CreationDate <= $DATE][ImageId]" --owners $OWNER --output text)
			# Set all Snapshots
			ALLSNAP=$(aws ec2 describe-snapshots --profile $PROFILE --query "Snapshots[?StartTime <= $DATE].{id:SnapshotId}" --owner-ids $OWNER --output text)
			# Delete orphan Snapshots
			echo "Delete Snapshots older than $DAYS days on `date +%Y-%m-%d`" | tee -a ~/Aws/aws_delete_snapshots.log
			while read LINE
			do 
				echo "$SNAPAMI" | grep "$LINE" 
				if [ $? -eq "1" ]; then
					echo "Orphan Snapshot deleted"
					echo "$LINE" | tee -a ~/Aws/aws_delete_snapshots.log
				    # Delete Snapshots
				    aws ec2 delete-snapshot --profile $PROFILE --snapshot-id $LINE
				else
					echo "$LINE belong to an AMI"
				fi
			done <<< "$ALLSNAP"
			;;
		"Delete unused Volumes") 
			echo "--------------"				
		    echo "You chose Delete unused Volumes"
			echo "--------------"
			echo "Delete unused volumes on `date +%Y-%m-%d`" | tee -a ~/Aws/aws_delete_volumes.log
			aws ec2 describe-volumes --profile $PROFILE --filters "Name=status,Values=available" --output text --query 'Volumes[*].{ID:VolumeId}' | xargs -n 1 -I % sh -c "echo % | tee -a ~/Aws/aws_delete_volumes.log; aws ec2 delete-volume --profile $PROFILE --volume-id=%"
			;;		
		"Quit") 
			break						
			;;		
		*)		
			echo "Error: Please try again (select 1..4)!"
			;;		
	esac
done 
