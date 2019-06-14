#!/usr/bin/env bash

#Delete the key pair that we have created
aws ec2 delete-key-pair --key-name $(aws ec2 describe-key-pairs --query 'KeyPairs[?contains(KeyName, `AWS`)].KeyName' --output text)
#This output should be empty
aws ec2 describe-key-pairs --key-name --query 'KeyPairs[?contains(KeyName, `AWS`)].KeyName' --output text

#Delete the security group
aws ec2 delete-security-group --group-id $(aws ec2 describe-security-groups --query 'SecurityGroups[?contains(GroupName, `AWS`)].GroupId' --output text)
#This output should be empty
aws ec2 describe-security-groups --query 'SecurityGroups[?contains(GroupName,`AWS`)].GroupId' --output text

