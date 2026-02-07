#!/usr/bin/env bash
set -e

TOMURL="https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz"

# Install Java, Git, Maven
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y openjdk-17-jdk openjdk-17-jre git wget unzip zip maven

# Download and install Tomcat
cd /tmp/
wget $TOMURL -O tomcatbin.tar.gz
EXTOUT=$(tar xzvf tomcatbin.tar.gz)
TOMDIR=$(echo $EXTOUT | cut -d '/' -f1)

sudo useradd --shell /usr/sbin/nologin tomcat || true
sudo rsync -avzh /tmp/$TOMDIR/ /usr/local/tomcat/
sudo chown -R tomcat:tomcat /usr/local/tomcat

# Create systemd service
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOT
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
Group=tomcat
WorkingDirectory=/usr/local/tomcat
Environment=JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat
ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

# Clone and build app
cd /tmp/
git clone -b local https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mvn clean install

# Deploy WAR
sudo systemctl stop tomcat
sleep 10
sudo rm -rf /usr/local/tomcat/webapps/ROOT*
sudo cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war
sudo systemctl start tomcat
sleep 10
sudo systemctl restart tomcat

