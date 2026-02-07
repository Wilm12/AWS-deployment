#!/usr/bin/env bash
set -e

sudo yum update -y
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx

# Configure reverse proxy
cat <<EOF | sudo tee /etc/nginx/conf.d/vproapp.conf
upstream vproapp {
    server tomcat_private_ip:8080;
}

server {
    listen 80;
    location / {
        proxy_pass http://vproapp;
    }
}
EOF

# Enable site and restart Nginx
sudo nginx -t
sudo systemctl enable nginx
sudo systemctl restart nginx

