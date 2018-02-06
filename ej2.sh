#!/bin/bash
docker network create network-docker

docker create --name datacontainer -v /var/lib/mysql -v /var/www/html busybox

docker run --network network-docker --name=db -p 3308:3308 -d -e MYSQL_ROOT_PASSWORD=Scuero11 -e MYSQL_DATABASE=db -e MYSQL_USER1=wordpress -e MYSQL_PASSWORD1=Scuero11 --volumes-from datacontainer orboan/dcsss-mariadb

docker run --network network-docker --name=apache -p 8069:80 -p 2222:22 -d --volumes-from datacontainer --dns 8.8.8.8 nerffrenasix/centos-httpd-php
