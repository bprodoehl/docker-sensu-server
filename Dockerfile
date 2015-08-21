FROM phusion/baseimage:0.9.17

MAINTAINER Brian Prodoehl <bprodoehl@connectify.me>

### Update the base image
RUN apt-get update && apt-get dist-upgrade -qy
RUN apt-get install -y wget

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

####### Enable RabbitMQ
RUN mkdir /etc/service/rabbitmq
ADD runit/rabbitmq.sh /etc/service/rabbitmq/run
RUN mkdir /etc/service/rabbitmq-setup
ADD runit/rabbitmq-setup.sh /etc/service/rabbitmq-setup/run

### Install Redis
RUN apt-get -y install redis-server
###### Enable Redis
RUN mkdir /etc/service/redis
ADD runit/redis.sh /etc/service/redis/run

### Install the Sensu Core Repository
RUN wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -
RUN echo "deb     http://repos.sensuapp.org/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list

### Install Sensu
RUN apt-get update
RUN apt-get install -y sensu

### Configure Sensu
ADD conf/config.json /etc/sensu/config.json

### Configure a Check
ADD conf/check_memory.json /etc/sensu/conf.d/check_memory.json
ADD conf/default_handler.json /etc/sensu/conf.d/default_handler.json

### Enable Sensu
RUN mkdir /etc/service/sensu-api
ADD runit/sensu-api.sh /etc/service/sensu-api/run
RUN mkdir /etc/service/sensu-server
ADD runit/sensu-server.sh /etc/service/sensu-server/run
