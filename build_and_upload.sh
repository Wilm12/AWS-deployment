#!/bin/bash
set -e  # stop on errors
set -o pipefail

APP_NAME="vprofile-v2"
BUCKET="wills3-bucket"

echo "[INFO] Cleaning and building WAR..."
mvn clean package -DskipTests

WAR_FILE="target/${APP_NAME}.war"

if [ ! -f "$WAR_FILE" ]; then
  echo "[ERROR] WAR file not found at $WAR_FILE"
  exit 1
fi

echo "[INFO] Uploading WAR to S3..."
aws s3 cp "$WAR_FILE" "s3://${BUCKET}/${APP_NAME}.war" --acl private

echo "[INFO] Upload complete: s3://${BUCKET}/${APP_NAME}.war"


