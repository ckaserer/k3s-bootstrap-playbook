# -*- mode: ruby -*-
# vi: set ft=ruby :

#########################
$CPU = 1
$MEMORY = 512
$CPUEXECUTIONCAP = 50 # does not work with hyper-v
$IP = "10.0.0.1"   # does not work with hyper-v # https://www.vagrantup.com/docs/hyperv/limitations.html
$BASEOS = "debian/buster64"
$SSH=2224
$HOSTNAME="k3s-bastion"
#########################

Vagrant.configure("2") do |config|
  config.vm.box = $BASEOS
  config.vm.hostname = $HOSTNAME

  config.vm.provider "virtualbox" do |v|
    v.memory = $MEMORY
    v.cpus = $CPU
    v.customize ["modifyvm", :id, "--cpuexecutioncap", $CPUEXECUTIONCAP]
  end

  config.vm.provider "hyperv" do |v|
    v.memory = $MEMORY
    v.cpus = $CPU
  end
  
  config.vm.provider "libvirt" do |v|
    v.memory = $MEMORY
    v.cpus = $CPU
  end
  
  config.vm.network "private_network", ip: $IP
  config.vm.network "forwarded_port", guest: 22, host: $SSH, id: 'ssh'

  config.vm.synced_folder ".", "/vagrant", type: "rsync" #type: "nfs"

  config.vm.provision "shell" do |shell|
    shell.path = ".ci/prepare.sh"
  end

  config.vm.provision "shell" do |shell|
    shell.path = ".ci/run.sh"
    shell.env = { "CICD_HOME":"/vagrant/.ci", "PLAYBOOK_HOME":"/vagrant" }
  end
  
end
