#/bin/sh
#Works only in compose-mode
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/ssl/extras/apache.key -out /etc/ssl/extras/apache.crt -subj /CN=$MY_DOMAIN

#JKLoads
sed '7 a       JkMount /webapp loadbalancer' /opt/local-ssl.conf.orig >  /etc/apache2/sites-available/local-ssl.conf

#seds
sed -i 's|MY_DOMAIN|'"$MY_DOMAIN"'|g' /etc/apache2/sites-available/local-ssl.conf

echo "127.0.0.1  $MY_DOMAIN" >> /etc/hosts

a2enmod ssl
a2ensite local-ssl

service apache2 start
tail -f /var/log/apache2/access.log
