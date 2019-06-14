#!/usr/bin/env bash
# Create a pair of keys (public and private) to give shh access to our ECS instances (See previous sh---vpc-groups.sh---)
# We can do it using two methods: using AWS ot OpenSSL(or other third-party)

NAME_KEY_PAIR=DevOpsAWS
LOCATION_PRIVATE_KEY=~/.ssh/id_rsa_${NAME_KEY_PAIR}.pem

# Writes the private key inside a certain location
echo $(aws ec2 create-key-pair --key-name ${NAME_KEY_PAIR} --query 'KeyMaterial' --output text) > ${LOCATION_PRIVATE_KEY}
chmod 600 ${LOCATION_PRIVATE_KEY}

# Print a json showing the key pair created
aws ec2 describe-key-pairs --key-name ${NAME_KEY_PAIR} --output json