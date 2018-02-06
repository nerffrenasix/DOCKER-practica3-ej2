# DOCKER-practica3-ej2

#!/bin/bash
docker network create network-ej2/*Aqui creamos la red de docker*/

/*DATACONTAINER*/

docker create --name datacontainer -v /var/lib/mysql -v /var/www/html busybox /*aqui creamos el datacontainer a partir de una imagen de busybox  en el que mapearemos los directorios de la base de datos y el apache*/

/*BASE DE DATOS*/

docker run --network network-ej2 --name=db -p 3308:3308 -d -e MYSQL_ROOT_PASSWORD=Scuero11 -e MYSQL_DATABASE=db -e MYSQL_USER1=wordpress -e MYSQL_PASSWORD1=Scuero11 --volumes-from datacontainer orboan/dcsss-mariadb/*Aqui creamos la base de datos, le decimos en que red queremos que este, le mapeamos  el puerto 3308 con el 3308 de nuestro huesped la ejecutanmos en segundo plano con “-d” y creamos los usuarios y passwords para la base de datos, los que pone root seran para entrar al gestor de base de datos y los otros seran para la base de datos que utilizaremos en el ejercicio, despues le decimos que utilice los volumenes de datacontainer y indicamos desde que imagen queremos crear el contenedor*/

/*APACHE*/

docker run --network network-ej2 --name=apache -p 8069:80 -p 2222:22 -d --volumes-from datacontainer --dns 8.8.8.8 nerffrenasix/centos-httpd-php/*Aqui crearemos la maquin en modo de ejecucion y mapearemos el puerto 8069 de nuestro huesped con el 80 del contenedor le asignaremos la red que hemos creado al principio y cogeremos los volumenes creados en el datacontainer, finalmente le pondremos el nombre y desde que imagen queremos crearlo*/

Enlace del SCRIPT en github: 


una vez ejecutado el script debemos ejecutar las siguientes comandas


Esta para entrar en el contenedor de apache
docker exec -it apache bash

Esta para entrar al directorio html dentro del contenedor
cd /var/www/html 

Con esta comanda descargaremos la ultima version de wordpress
wget https://wordpress.org/latest.tar.gz 

Aqui descomprimimos el archivo
tar -xvf latest.tar.gz 

Borramos el archivo comprimido
rm -f latest.tar.g 

movemos los archivo de wordpress a la carpeta html
mv /var/www/html/wordpress/* /var/www/html

Borramnos la carpeta de wordpress 
rm -rf /var/www/html/wordpress 

y le damos los siguientes permisos
chown -R apache:apache /var/www/html 
chmod -R 755 /var/www/html 
