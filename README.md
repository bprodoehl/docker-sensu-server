# docker-sensu-server
A Docker container for a production-ready Sensu core server

This is a work-in-progress.

### Environment variables

 * AMQP_VHOST - defaults to /sensu
 * AMQP_USER - defaults to sensu
 * AMQP_PASSWORD - defaults to secret


### Getting Started
```
docker run -d --name sensu-server -p 4567:4567 -p 5671:5671 --hostname sensu-server bprodoehl/sensu-server
docker run -d --name uchiwa -p 3000:3000 -v /etc/uchiwa:/config --hostname uchiwa uchiwa/uchiwa
```
