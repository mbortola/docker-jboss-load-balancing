#/bin/sh


echo "Node name: $NODE_NAME"

/home/jboss/EAP-6.4.0/jboss-eap-6.4/bin/standalone.sh  --server-config=standalone-ha.xml -Djboss.node.name=$NODE_NAME
