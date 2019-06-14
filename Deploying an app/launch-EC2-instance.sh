#!/usr/bin/env bash

KEYNAME=$(aws ec2 describe-key-pairs --query 'KeyPairs[?contains(KeyName,`AWS`)].KeyName' --output text)
INSTANCE_TYPE=t2.micro
GROUP_ID=$(aws ec2 describe-security-groups --query 'SecurityGroups[?contains(GroupName, `AWS`)].GroupId' --output text)
# aws ec2 describe-images --filters "Name=description,Values=Amazon Linux AMI * x86_64 HVM GP2" --query 'Images[*].[CreationDate, Description,ImageId]' --output text | sort -k 1 | tail #### Take the most recent
IMAGE_ID=ami-6c9eb509

#Run the instance
aws ec2 run-instances --instance-type ${INSTANCE_TYPE} --key-name ${KEYNAME} --security-group-ids ${GROUP_ID} --image-id ${IMAGE_ID} # --dry-run -> OPTIONAL// I dont run this command because I cant pay the bill, so It hasnt created a revert for the instance

#Get the instance id
INSTANCE_ID=$(aws ec2 describe-instances --filter "Name=group-id,Values=${GROUP_ID}" "Name=key-name,Values=${KEYNAME}" "Name=image-id,Values=${IMAGE_ID}" "Name=instance-type,Values=${INSTANCE_TYPE}" --query 'Instances[*].InstanceId')

#Show the status of the instance
aws ec2 describe-instance-status --instance-ids ${INSTANCE_ID}