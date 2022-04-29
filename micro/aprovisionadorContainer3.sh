#!/bin/bash

#script instalacion contenedor LXD con web server
#echo "actualizando Ubuntu"
#sudo apt-get update -y

echo "instalacion LXD"
sudo apt-get install lxd -y
sudo newgrp lxd


echo "configuracion container"
sudo lxc launch ubuntu/18.04 myweb2  --target web2
sleep 20
echo "configuracion apache"
sudo lxc exec myweb2 -- apt-get install net-tools -y
sudo lxc exec myweb2 -- apt-get install apache2 -y
sudo lxc exec myweb2 -- systemctl enable apache2

echo "configuracion container backup"
sudo lxc launch ubuntu/18.04 myweb2Backup  --target web2
sleep 20
echo "configuracion apache del backup"
sudo lxc exec myweb2Backup -- apt-get install net-tools -y
sudo lxc exec myweb2Backup -- apt-get install apache2 -y
sudo lxc exec myweb2Backup -- systemctl enable apache2

echo "configuracion pagina web"
sudo lxc file push /vagrant/index.html myweb2/var/www/html/index.html
sudo lxc file push /vagrant/index.html myweb2Backup/var/www/html/index.html

echo "reiniciar servidor apache"
sudo lxc exec myweb2 -- systemctl restart apache2
sudo lxc exec myweb2Backup -- systemctl restart apache2

#echo "redireccionar puertos"
#sudo lxc config device add myweb2 myport80 proxy listen=tcp:192.168.100.2:5080 connect=tcp:127.0.0.1:80
