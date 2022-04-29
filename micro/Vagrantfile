# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define :serverBalancer do |node|
    node.vm.box = "bento/ubuntu-20.04"
    node.vm.network :private_network, ip: "192.168.100.10"
    node.vm.provision "shell", path: "aprovisionadorCluster1.sh"
    node.vm.provision "shell", path: "aprovisionadorContainer1.sh"
    node.vm.hostname = "serverBalancer"
  end

  config.vm.define :web1 do |node|
    node.vm.box = "bento/ubuntu-20.04"
    node.vm.network :private_network, ip: "192.168.100.11"
    node.vm.provision "shell", path: "aprovisionadorCluster2.sh"
    node.vm.provision "shell", path: "aprovisionadorContainer2.sh"
    node.vm.hostname = "web1"
  end

  config.vm.define :web2 do |node|
    node.vm.box = "bento/ubuntu-20.04"
    node.vm.network :private_network, ip: "192.168.100.12"
    node.vm.provision "shell", path: "aprovisionadorCluster3.sh"
    node.vm.provision "shell", path: "aprovisionadorContainer3.sh"
    node.vm.hostname = "web2"
  end

end