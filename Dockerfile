FROM phusion/baseimage:0.9.17

MAINTAINER Brian Prodoehl <bprodoehl@connectify.me>

ENV HOME /root

### Update the base image
RUN apt-get update && apt-get dist-upgrade -qy
RUN apt-get install -y curl wget supervisor

### Install RabbitMQ
###### Step #1: Install Erlang
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get -y install erlang

###### Step #2: Install RabbitMQ
RUN wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN apt-key add rabbitmq-signing-key-public.asc
RUN "deb     http://www.rabbitmq.com/debian/ testing main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get update
RUN apt-get -y install rabbitmq-server
RUN mkdir -p /var/run/rabbitmq /var/log/rabbitmq
RUN chown rabbitmq:rabbitmq /var/run/rabbitmq
RUN chown rabbitmq:rabbitmq /var/log/rabbitmq
ADD conf/rabbitmq.config /etc/rabbitmq/rabbitmq.config
ADD conf/rabbitmq-env.conf /etc/rabbitmq/rabbitmq-env.conf

### Install Redis
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
RUN echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/redis.list
RUN apt-get update && apt-get -y install redis-server
ADD conf/redis.conf /etc/redis.conf

### Install the Sensu Core Repository
RUN wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -
RUN echo "deb     http://repos.sensuapp.org/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list

### Install Sensu
RUN apt-get update
RUN apt-get install -y sensu

### Configure Sensu
ADD conf/config.json.template /etc/sensu/config.json.template
RUN mkdir -p /var/log/sensu-api /var/log/sensu-server

### Configure a Check
ADD conf/check_memory.json /etc/sensu/conf.d/check_memory.json
ADD conf/default_handler.json /etc/sensu/conf.d/default_handler.json

### Configure Sensu client
ADD conf/client-config.json /etc/sensu/conf.d/config.json
ADD conf/check-memory.sh /etc/sensu/plugins/check-memory.sh

### Add scripts to generate TLS certs
RUN mkdir /root/sensu_certs
ADD files/openssl.cnf /root/sensu_certs/openssl.cnf
ADD files/ssl_certs.sh /root/sensu_certs/ssl_certs.sh

### Configure Runit
RUN mkdir /etc/service/rabbitmq
ADD runit/rabbitmq.sh /etc/service/rabbitmq/run
RUN mkdir /etc/service/redis
ADD runit/redis.sh /etc/service/redis/run
RUN mkdir /etc/service/sensu-api
ADD runit/sensu-api.sh /etc/service/sensu-api/run
RUN mkdir /etc/service/sensu-client
ADD runit/sensu-client.sh /etc/service/sensu-client/run
RUN mkdir /etc/service/sensu-server
ADD runit/sensu-server.sh /etc/service/sensu-server/run
ADD runit/generate-certs.sh /etc/my_init.d/010-generate-certs.sh

EXPOSE 80 4567 5671 15672
