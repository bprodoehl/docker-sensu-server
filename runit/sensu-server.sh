#!/bin/sh

set -eu

RUNDIR=/var/run/sensu-server
PIDFILE=$RUNDIR/sensu-server.pid

mkdir -p $RUNDIR
touch $PIDFILE
chown sensu:sensu $RUNDIR $PIDFILE
chmod 755 $RUNDIR

exec chpst -u sensu /opt/sensu/bin/sensu-server -d /etc/sensu -p $PIDFILE
