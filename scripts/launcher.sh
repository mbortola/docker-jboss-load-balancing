#!/bin/bash

 openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ../apache2/files/certs/apache.key -out ../apache2/files/certs/apache.crt -subj /CN=identity.local.infocert.it

 #docker build -t web-server ../apache2

 #docker build -t jboss ../jboss

 docker-compose up
