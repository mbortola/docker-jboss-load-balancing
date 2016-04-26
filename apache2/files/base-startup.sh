#!/bin/sh
#Simply start apache
service apache2 start
tail -f /var/log/apache2/access.log
