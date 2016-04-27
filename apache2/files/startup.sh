#!/bin/sh
#Works only in compose-mode
#echo "Creating certificate.."
#openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/extras/apache.key -out /etc/ssl/extras/apache.crt -subj /CN=$MY_DOMAIN
#echo "..certificate created, some seds.."
#JKLoads
sed '7 a       JkMount /webapp loadbalancer' /opt/local-ssl.conf.orig >  /etc/apache2/sites-available/local-ssl.conf

#seds
sed -i 's|MY_DOMAIN|'"$MY_DOMAIN"'|g' /etc/apache2/sites-available/local-ssl.conf

echo "127.0.0.1  $MY_DOMAIN" >> /etc/hosts

echo "Starting web server.."

a2enmod ssl
a2ensite local-ssl

service apache2 start
echo "..web server ready!"
tail -f /var/log/apache2/access.log
