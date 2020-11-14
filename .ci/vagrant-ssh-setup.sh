#!/bin/bash

cp /vagrant/id_rsa /root/.ssh/id_rsa
cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa

chmod 600 /root/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa

cat /vagrant/id_rsa.pub >> /root/.ssh/authorized_keys
cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

chown -R vagrant:vagrant /home/vagrant/.ssh