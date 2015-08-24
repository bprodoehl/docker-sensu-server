#!/bin/sh
set -eu

export HOME=/var/lib/rabbitmq

exec chpst -u rabbitmq /usr/sbin/rabbitmq-server
