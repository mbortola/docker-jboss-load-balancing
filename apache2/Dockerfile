# Use the centos 6.7 base image
FROM ubuntu:latest

MAINTAINER Michele Bortolato <michele.bortolato@infocert.it>

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get install -y  software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer apache2 libapache2-mod-jk && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ADD files/workers.properties /etc/libapache2-mod-jk/workers.properties
ADD files/startup.sh /opt/

RUN usermod -U www-data && chsh -s /bin/bash www-data && chmod +x /opt/startup.sh

ENTRYPOINT /opt/startup.sh

# To loadbalance add stuff like
#<VirtualHost *:80>
#       JkMount /webapp* loadbalancer

