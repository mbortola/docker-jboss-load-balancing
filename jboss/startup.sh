#!/bin/sh

$JAVA_HOME/bin/keytool -import -trustcacerts -file /etc/ssl/extras/apache.crt -alias ssl-web-server -noprompt -keystore $JAVA_HOME/jre/lib/security/cacerts -keypass changeit -storepass changeit

# retrieve binding ip
export BIND_IP=`ifconfig | grep "inet " | grep broadcast | awk '{print $2}'`

echo "Node name: $NODE_NAME: bind-address at $BIND_IP"

# Start the jboss, run configuration script and tail server.log
/home/jboss/EAP-6.4.0/jboss-eap-6.4/bin/standalone.sh  --server-config=standalone-ha.xml -b $BIND_IP &

/home/jboss/EAP-6.4.0/jboss-eap-6.4/bin/jboss-cli -c --file=/opt/configure.txt

fg
