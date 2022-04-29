#!/bin/bash

#script instalacion contenedor LXD con web server
#echo "actualizando Ubuntu"
#sudo apt-get update -y

echo "instalacion LXD"
sudo apt-get install lxd -y
sudo newgrp lxd


echo "configuracion container"
sudo lxc launch ubuntu/18.04 myweb1  --target web1
sleep 20
echo "configuracion apache"
sudo lxc exec myweb1 -- apt-get install net-tools -y
sudo lxc exec myweb1 -- apt-get install apache2 -y
sudo lxc exec myweb1 -- systemctl enable apache2

echo "configuracion container Backup"
sudo lxc launch ubuntu/18.04 myweb1Backup  --target web1
sleep 20
echo "configuracion apache para el backup"
sudo lxc exec myweb1Backup -- apt-get install net-tools -y
sudo lxc exec myweb1Backup -- apt-get install apache2 -y
sudo lxc exec myweb1Backup -- systemctl enable apache2


echo "configuracion pagina web"
sudo lxc file push /vagrant/index.html myweb1/var/www/html/index.html
sudo lxc file push /vagrant/index.html myweb1Backup/var/www/html/index.html

echo "reiniciar servidor apache"
sudo lxc exec myweb1 -- systemctl restart apache2
sudo lxc exec myweb1Backup -- systemctl restart apache2

#echo "redireccionar puertos"
#sudo lxc config device add myweb1 myport80 proxy listen=tcp:192.168.100.2:5080 connect=tcp:127.0.0.1:80
