#!/bin/sh
set -eu

exec chpst -u rabbitmq /usr/sbin/rabbitmq-server
