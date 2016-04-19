# docker-jboss-load-balancing

## Ingredients:

* docker
* docker-compose
* oracle java 8
* apache2 on ubuntu container
  * libapache2-modjk to load balance
* jboss 6.4 on centos container
  * eventually patched 

## Description
This project use docker-compose to orchestrate 3 container: 1 with apache2 and 2 (but it coul easily grow) with jboss eap (i tested it with a 6.4.6 eap). 

## Steps

0. download a valid version of jboss and eventually its patches, eventually change or comment paths and env variables to match your purposes,
1. make a *docker build -t jboss .* into jboss directory, it will create the container with jboss, which is used 2 times into the composer,
2. launch a *docker-compose up* and see what happens, the 3 containers will raise up
 
### Other things to do

every container has ist launcher.sh, chech it out to match you purposes


## How can i load balance the thing?

Let's suppose that you have a testapp.war, you put into your containers and it exposes a context named *testapp*, so .p.e you can go into your apache container ( *docker exec -it loadbalancing_apache_1 /bin/bash* ) and curl 

> curl first.node:8080/testapp/my/path

or 

> curl second.node:8080/testapp/my/path


for a load balance edit */etc/apache2/sites-enabled/000-default.conf* with

```
<VirtualHost *:80>
  JKMount /testapp* loadbalancer
```

then

> service apache2 restart

and form the host you can load balanche with

> 127.0.0.1/testapp/my/path


## References
 
Base project from which i created my jboss container
> https://github.com/fbascheper/JBoss-EAP-Docker-image

Other useful links:
> https://docs.jboss.org/author/display/AS71/Using+mod_jk+with+JBoss+AS7
> https://docs.jboss.org/author/display/AS71/AS7+Cluster+Howto
 


