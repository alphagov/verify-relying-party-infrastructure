#!/bin/bash
apt-get update -y
apt-get install -y apache2
groupadd www
usermod -a -G www ubuntu
chown -R root:www /var/www
chmod 2775 /var/www
