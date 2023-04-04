#!/bin/bash
set -e

if [ $NAT = "true" -a -z "$EXTERNAL_IP" ]; then

  # Try to get public IP
  PUBLIC_IP=$(curl http://icanhazip.com) || exit 1

  # Try to get private IP
  PRIVATE_IP=$(ifconfig | awk '/inet addr/{print substr($2,6)}' | grep -v 127.0.0.1) || exit 1
  export EXTERNAL_IP="$PUBLIC_IP/$PRIVATE_IP"
  echo "Starting turn server with external IP: $EXTERNAL_IP"
fi

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
