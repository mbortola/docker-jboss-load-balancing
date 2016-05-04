#!/bin/sh
#Works only in compose-mode

#JKLoads
sed -i '7 a       JkMount /webapp loadbalancer' /opt/local-ssl.conf

#seds
sed -i 's|MY_DOMAIN|'"$MY_DOMAIN"'|g' /opt/local-ssl.conf

mv /opt/local-ssl.conf /etc/apache2/sites-available/

echo "127.0.0.1  $MY_DOMAIN" >> /etc/hosts

echo "Starting web server.."

a2enmod ssl
a2ensite local-ssl

service apache2 start
echo "..web server ready!"
tail -f /var/log/apache2/access.log
