#!/bin/bash
set -e

# Update system
sudo dnf update -y

# Install MariaDB (Amazon Linux 2023)
sudo dnf install -y mariadb105-server

# Start and enable MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure root user
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'admin123';"
sudo mysql -u root -padmin123 -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -u root -padmin123 -e "DROP DATABASE IF EXISTS test;"
sudo mysql -u root -padmin123 -e "FLUSH PRIVILEGES;"

# Create application database and user
mysql -u root -padmin123 <<EOF
CREATE DATABASE accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
EOF

sudo systemctl restart mariadb

