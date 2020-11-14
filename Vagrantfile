# -*- mode: ruby -*-
# vi: set ft=ruby :

#########################
$CPU = 1
$MEMORY = 512
$CPUEXECUTIONCAP = 50 # does not work with hyper-v
$IP = "10.0.0.2"   # does not work with hyper-v # https://www.vagrantup.com/docs/hyperv/limitations.html
$BASEOS = "generic/debian10"
$SSH=2224
$HOSTNAME="k3s-bastion"
#########################

Vagrant.configure("2") do |config|
  
  config.vm.define "bastion" do |node|
    node.vm.box = $BASEOS
    node.vm.hostname = $HOSTNAME
  
    node.vm.provider "virtualbox" do |v|
      v.memory = $MEMORY
      v.cpus = $CPU
      v.customize ["modifyvm", :id, "--cpuexecutioncap", $CPUEXECUTIONCAP]
    end
  
    node.vm.provider "hyperv" do |v|
      v.memory = $MEMORY
      v.cpus = $CPU
    end
    
    node.vm.provider "libvirt" do |v|
      v.memory = $MEMORY
      v.cpus = $CPU
    end
    
    node.vm.network "private_network", ip: $IP
    node.vm.network "forwarded_port", guest: 22, host: $SSH, id: 'ssh'
    
    node.vm.synced_folder ".", "/vagrant", type: "rsync" #type: "nfs"
  
    node.vm.provision "shell" do |shell|
      shell.path = ".ci/vagrant-ssh-setup.sh"
    end
    node.vm.provision "shell" do |shell|
      shell.path = ".ci/vagrant-prepare.sh"
    end
  
  end
  
  config.vm.define "bootstrap" do |node|
    node.vm.box = $BASEOS
    node.vm.hostname = "bootstrap"
  
    node.vm.provider "virtualbox" do |v|
      v.memory = $MEMORY
      v.cpus = $CPU
      v.customize ["modifyvm", :id, "--cpuexecutioncap", $CPUEXECUTIONCAP]
    end
  
    node.vm.provider "hyperv" do |v|
      v.memory = $MEMORY
      v.cpus = $CPU
    end
    
    node.vm.provider "libvirt" do |v|
      v.memory = $MEMORY
      v.cpus = $CPU
    end
    
    node.vm.network "private_network", ip: "10.0.0.3"
    #node.vm.network "forwarded_port", guest: 22, host: 2222, id: 'ssh'
  
    node.vm.synced_folder ".", "/vagrant", type: "rsync" #type: "nfs"
    
    node.vm.provision "shell" do |shell|
      shell.path = ".ci/vagrant-ssh-setup.sh"
    end
    node.vm.provision "shell" do |shell|
      shell.path = ".ci/vagrant-prepare.sh"
    end
  
    node.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbook.yml"
      ansible.verbose = "v"
      ansible.limit = "all"
      ansible.inventory_path = "/vagrant/.ci/inventory"
      ansible.galaxy_role_file = "/vagrant/requirements.yml"
    end
  end
end
