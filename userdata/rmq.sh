

#!/bin/bash
set -e

sudo dnf update -y
sudo dnf install -y erlang rabbitmq-server

sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# Allow guest access remotely
echo "loopback_users.guest = false" | sudo tee /etc/rabbitmq/rabbitmq.conf
sudo systemctl restart rabbitmq-server

# Create application user
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

