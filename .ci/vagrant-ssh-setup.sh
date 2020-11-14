#!/bin/bash

cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/id_rsa
chown -R vagrant:vagrant /home/vagrant/.ssh