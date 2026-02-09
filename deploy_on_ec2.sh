#!/bin/bash
set -e

# Step 1: Pull artifact from S3
echo "Pulling artifact from S3..."
aws s3 cp s3://wills3-bucket/vprofile.war /var/lib/tomcat/webapps/vprofile.war

# Step 2: Restart Tomcat
echo "Restarting Tomcat..."
sudo systemctl restart tomcat

echo "Deployment complete!"

