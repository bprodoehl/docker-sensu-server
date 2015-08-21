#!/bin/sh

set -eu

###### Configure RabbitMQ
# Create vhost
rabbitmqctl add_vhost /sensu

# Create user
rabbitmqctl add_user sensu secret
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
