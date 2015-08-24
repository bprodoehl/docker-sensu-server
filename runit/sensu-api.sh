#!/bin/sh

set -eu

RUNDIR=/var/run/sensu-api
PIDFILE=$RUNDIR/sensu-api.pid

mkdir -p $RUNDIR
touch $PIDFILE
chown sensu:sensu $RUNDIR $PIDFILE
chmod 755 $RUNDIR

exec chpst -u sensu /opt/sensu/bin/sensu-api -d /etc/sensu -p $PIDFILE
