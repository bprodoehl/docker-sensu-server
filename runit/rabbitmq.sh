#!/bin/sh
set -eu

#RUNDIR=/var/run/rabbitmq
#PIDFILE=$RUNDIR/rabbitmq.pid

#mkdir -p $RUNDIR
#touch $PIDFILE
#chown rabbitmq:rabbitmq $RUNDIR $PIDFILE
#chmod 755 $RUNDIR

exec chpst -u rabbitmq /usr/sbin/rabbitmq-server
