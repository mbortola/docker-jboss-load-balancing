#!/bin/sh

$JAVA_HOME/bin/keytool -import -trustcacerts -file /etc/ssl/extras/apache.crt -alias ssl-web-server -noprompt -keystore $JAVA_HOME/jre/lib/security/cacerts -keypass changeit -storepass changeit

export BIND_IP=`ifconfig | grep "inet " | grep broadcast | awk '{print $2}'`

echo "Node name: $NODE_NAME: bind-address at $BIND_IP"

# old/home/jboss/EAP-6.4.0/jboss-eap-6.4/bin/standalone.sh  --server-config=standalone-ha.xml -Djboss.node.name=$NODE_NAME
/home/jboss/EAP-6.4.0/jboss-eap-6.4/bin/standalone.sh  --server-config=standalone-ha.xml -b $BIND_IP
