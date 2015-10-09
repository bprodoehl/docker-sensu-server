# docker-sensu-server
A Docker container for a production-ready Sensu core server

This is a work-in-progress.

### Environment variables

 * AMQP_VHOST - defaults to /sensu
 * AMQP_USER - defaults to sensu
 * AMQP_PASSWORD - defaults to secret
 * SENSU_API_PORT - defaults to 4567
 * SENSU_API_USER - defaults to admin
 * SENSU_API_PASSWORD - defaults to secret

### Getting Started
```
docker run -d --name sensu-server -p 4567:4567 -p 5671:5671 --hostname sensu-server bprodoehl/sensu-server
docker run -d --name uchiwa -p 3000:3000 -v /etc/uchiwa:/config --hostname uchiwa uchiwa/uchiwa
```

A slightly more complete set of commands:
```
docker run -d --name sensu-server \
           -p 80:80 -p 5671:5671 \
           --hostname sensu-server \
           --env AMQP_VHOST=/sensu2 \
           --env AMQP_USER=supersecretuser \
           --env AMQP_PASSWORD=MyReallyL0ngP4ssw0rd \
           --env SENSU_API_PORT=80 \
           --env SENSU_API_USER=myapiuser \
           --env SENSU_API_PASSWORD=myapipassword \
           --env VIRTUAL_HOST=sensu-server.mydomain.com \
           bprodoehl/sensu-server
```
