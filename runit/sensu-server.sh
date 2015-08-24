#!/bin/sh
set -eu

sv start rabbitmq || exit 1
sleep 5.0

###### Configure RabbitMQ
set +e
# Create vhost
rabbitmqctl add_vhost /sensu
# Create user
rabbitmqctl add_user sensu secret
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"

set -e

RUNDIR=/var/run/sensu-server
PIDFILE=$RUNDIR/sensu-server.pid

mkdir -p $RUNDIR
touch $PIDFILE
chown sensu:sensu $RUNDIR $PIDFILE
chmod 755 $RUNDIR

exec chpst -u sensu /opt/sensu/bin/sensu-server -d /etc/sensu -p $PIDFILE
