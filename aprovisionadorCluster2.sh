#!/bin/bash

apt-get update

echo "instalacion LXD"
sudo apt-get install lxd -y

echo "Implementacion de Cluster"
sudo gpasswd -a vagrant lxd

sudo rm lxdconfig.yaml

clustercertificado=$(</vagrant/clustercer.crt)
echo "$clustercertificado"


cat >> lxdconfig.yaml << EOF
config: {}
networks: []
storage_pools: []
profiles: []
cluster:
  server_name: web1
  enabled: true
  member_config:
  - entity: storage-pool
    name: local
    key: source
    value: ""
    description: '"source" property for storage pool "local"'
  cluster_address: 192.168.100.10:8443
  cluster_certificate: |
$clustercertificado
  server_address: 192.168.100.11:8443
  cluster_password: admin
  cluster_certificate_path: ""
  cluster_token: ""

EOF

echo "Inicializar LXD Usando Archivo Preseed"
cat lxdconfig.yaml |sudo lxd init --preseed
lxc cluster list

