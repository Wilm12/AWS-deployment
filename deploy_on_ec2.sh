#!/bin/bash
set -e
set -o pipefail

APP_NAME="vprofile-v2"
BUCKET="wills3-bucket"
TOMCAT_WEBAPPS="/var/lib/tomcat10/webapps"

echo "[INFO] Fetching WAR from S3..."
aws s3 cp "s3://${BUCKET}/${APP_NAME}.war" "${TOMCAT_WEBAPPS}/ROOT.war"

echo "[INFO] Restarting Tomcat..."
sudo systemctl restart tomcat10

echo "[INFO] Deployment complete. Check catalina.out for logs."


