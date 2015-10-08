#!/bin/sh
set -eu

sv start rabbitmq || exit 1
sleep 15.0

RUNDIR=/var/run/sensu-client
PIDFILE=$RUNDIR/sensu-client.pid

mkdir -p $RUNDIR
touch $PIDFILE
chown sensu:sensu $RUNDIR $PIDFILE
chmod 755 $RUNDIR

exec chpst -u sensu /opt/sensu/bin/sensu-client -d /etc/sensu -p $PIDFILE
