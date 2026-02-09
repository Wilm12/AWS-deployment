#!/bin/bash
set -e

# Step 1: Build the app
echo "Building vprofile-app with Maven..."
cd ../vprofile-app/app
mvn clean install

# Step 2: Upload artifact to S3
echo "Uploading artifact to S3..."
aws s3 cp target/vprofile.war s3://wills3-bucket/vprofile.war

echo "Artifact uploaded successfully!"

