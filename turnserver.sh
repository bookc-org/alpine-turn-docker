#!/bin/bash
set -e

# Try to get public IP
PUBLIC_IP=$(curl http://icanhazip.com) || exit 1

# Try to get private IP
PRIVATE_IP=$(ifconfig | awk '/inet addr/{print substr($2,6)}' | grep -v -e 127.0.0.1 -e 127.0.0.1 -e 172.18.0.1 -e 172.17.0.1) || exit 1
echo "Starting turn server with PUBLIC_IP: $PUBLIC_IP PRIVATE_IP:$PRIVATE_IP"

#内网IP
echo "listening-ip=$PRIVATE_IP" > /opt/turn/turnserver.conf
echo 'listening-port=3478' >> /opt/turn/turnserver.conf
echo "relay-ip=$PRIVATE_IP" >> /opt/turn/turnserver.conf
#公网IP
echo "external-ip=$PUBLIC_IP" >> /opt/turn/turnserver.conf
echo 'min-port=49152' >> /opt/turn/turnserver.conf
echo 'max-port=65535' >> /opt/turn/turnserver.conf
echo "user=$TURN_USERNAME:$TURN_PASSWORD" >> /opt/turn/turnserver.conf
echo "realm=$REALM" >> /opt/turn/turnserver.conf

#echo 'fingerprint' >> /opt/turn/turnserver.conf
#echo 'lt-cred-mech' >> /opt/turn/turnserver.conf
#echo 'log-file stdout' >> /opt/turn/turnserver.conf
exec turnserver -v -a -c /opt/turn/turnserver.conf
