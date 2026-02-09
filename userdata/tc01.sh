
#!/bin/bash
# Update packages
apt update -y

# Install Tomcat
apt install tomcat10 -y

# Install unzip (needed for AWS CLI v2)
apt install unzip -y

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Pull WAR from S3
aws s3 cp s3://wills3-bucket/vprofile-v2.war /var/lib/tomcat9/webapps/ROOT.war

# Restart Tomcat
systemctl restart tomcat10

