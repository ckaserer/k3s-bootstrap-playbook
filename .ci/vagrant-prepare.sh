#!/bin/bash

apt-get update -y
apt-get install -y python3 python3-pip
pip3 install -r /vagrant/requirements.txt

cp /vagrant/.ci/config.yml /vagrant/config.yml
