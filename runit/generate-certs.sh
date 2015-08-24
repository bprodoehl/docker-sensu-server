#!/bin/sh

cd /root/sensu_certs/
./ssl_certs.sh clean
./ssl_certs.sh generate

mkdir -p /etc/rabbitmq/ssl
cp server_key.pem /etc/rabbitmq/ssl/
cp server_cert.pem /etc/rabbitmq/ssl/
cp testca/cacert.pem /etc/rabbitmq/ssl/
