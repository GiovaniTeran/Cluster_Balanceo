#!/bin/bash

#script instalacion contenedor LXD con web server
#echo "actualizando Ubuntu"
#sudo apt-get update -y

echo "instalacion LXD"
sudo apt-get install lxd -y
sudo newgrp lxd

echo "configuracion container"
sudo lxc launch ubuntu/18.04 haproxy --target serverBalancer
sleep 10
sudo lxc exec haproxy -- apt update && apt upgrade -y
sudo lxc exec haproxy -- apt install haproxy -y

echo "ejecucion del haproxy"
sudo lxc exec haproxy -- systemctl enable haproxy

echo "configuracion haproxy.cfg"
sudo lxc file push /vagrant/haproxy.cfg haproxy/etc/haproxy/haproxy.cfg

echo "reiniciar servidor haproxy"
sudo lxc exec haproxy -- systemctl restart haproxy

#echo "redireccionar puertos"
sudo lxc config device add haproxy http proxy listen=tcp:0.0.0.0:5080 connect=tcp:127.0.0.1:80