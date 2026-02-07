#!/bin/bash
set -e

sudo dnf update -y
sudo dnf install -y memcached

sudo systemctl start memcached
sudo systemctl enable memcached

# Allow external connections
sudo sed -i 's/-l 127.0.0.1/-l 0.0.0.0/' /etc/sysconfig/memcached
sudo systemctl restart memcached


