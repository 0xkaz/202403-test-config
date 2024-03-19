#!/bin/#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <ADMIN_PRIVATE_KEY> <NODE_HOST_NAME>"
  exit 1
fi

# Retrieve the secret key from the command line argument
ADMIN_PRIVATE_KEY=$1
NODE_HOST_NAME=$2

# Install necessary packages
sudo apt-get update -y
sudo apt-get install jq awscli -y 

# Fetch the public IP address from EC2 metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600") && curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4 > /tmp/ip.txt

# Set the hostname
echo 'test.raas.weavedb-node.xyz' > /tmp/hostname.txt

# Create necessary directories
sudo mkdir -p /root/weavedb/conf
sudo mkdir -p /root/weavedb/envoy

# Clone the weavedb repository
cd / && sudo git clone https://github.com/weavedb/weavedb/

# Create the environment variables file
cat <<EOF > /tmp/standalone.env
ADMIN_PRIVATE_KEY=$ADMIN_PRIVATE_KEY
NODE_HOST_NAME=$NODE_HOST_NAME
HTTPS_DOMAIN=$NODE_HOST_NAME
LISTEN_PORT=8080
ADMIN_LISTEN_PORT=9901
SERVICE_DISCOVERY_ADDRESS=node-server
SERVICE_DISCOVERY_PORT=9090
EOF

# Copy the environment variables file
sudo cp /tmp/standalone.env /root/weavedb/standalone.env 
sudo cp /tmp/standalone.env /weavedb/grpc-node/node-server/


