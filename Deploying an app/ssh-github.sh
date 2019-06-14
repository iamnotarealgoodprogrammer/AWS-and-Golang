#!/usr/bin/env bash

USERNAME=iamnotarealgoodprogrammer
PROJECT=AWS-and-Golang
PATH=/home/{user}/.ssh/id_rsa_${USERNAME}_${PROJECT}

ssh-keygen -t rsa -b 4096 -C "${USERNAME}@gmail.com"
    # Enter the path --> $PATH
    # Enter the passphrase --> {this is a passphrase to gain access to the private pair}
    # Enter again the passphrase --> {write it again}
    # Print information

# Start the ssh-agent in the background.
eval "$(ssh-agent -s)"

# Add the key private
ssh-add $PATH
    # Enter the passphrase for the key pair
    # if successful, it will be added; else not

cat ${PATH}.pub
#Copy the output and paste on the github deploy keys