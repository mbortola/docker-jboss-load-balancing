# Use the centos 6.7 base image
FROM ubuntu:latest

MAINTAINER Michele Bortolato <michele.bortol@gmail.com>

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y openjdk-8-jre apache2 libapache2-mod-jk && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
RUN echo
ADD files/workers.properties /etc/libapache2-mod-jk/workers.properties
ADD files/startup.sh /opt/
ADD files/base-startup.sh /opt/
ADD files/local-ssl.conf /opt/local-ssl.conf

RUN usermod -U www-data && chsh -s /bin/bash www-data && chmod +x /opt/*startup.sh

ENTRYPOINT /opt/base-startup.sh
