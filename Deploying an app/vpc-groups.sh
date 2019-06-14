#!/usr/bin/env bash
# AWS EC2
# Goal: create two security groups: one to connect across TCP/3000 and other using ssh TCP/22
# Extra: If you know how to find out your public IP, you can improve the ssh rule by replacing 0.0.0.0/0 with your-ip/32 so that only you can try to ssh into that ec2-instance.

#First step is get the vpcid of the VPC that we hace to create a security group and assign to it the VPC
VPCID_DEFAULT=$(aws ec2 describe-vpcs --query 'Vpcs[?InstanceTenancy==`default` && State==`available` && IsDefault==`true`].VpcId' --output text)

#Second is Create the security group
GROUPID=$(aws ec2 create-security-group --group-name HelloAWS --description "Say Hello AWS!" --vpc-id ${VPCID_DEFAULT})
GROUPNAME=$(aws ec2 describe-security-groups --group-ids sg-09649623700c8b507 --query 'SecurityGroups[*].GroupName' --output text)

#Third is authorize to the group to listen by ports tcp/22 (ssh) and tcp/3000 for inbound traffic. By default, all instances of security groups allow all outbound traffic
aws ec2 authorize-security-group-ingress --group-name ${GROUPNAME} --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ${GROUPNAME} --protocol tcp --port 3000 --cidr 0.0.0.0/0

#List IpPermissions of the security-group HelloAWS:
aws ec2 describe-security-groups --group-name HelloAWS --query 'SecurityGroups[*].IpPermissions[?IpProtocol==`tcp`]' --output json