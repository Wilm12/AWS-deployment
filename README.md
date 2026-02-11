
# 🚀 AWS Automated Deployment Project

## 📘 Overview
This project demonstrates **end‑to‑end DevOps automation on AWS**, deploying a Java web application with Tomcat, artifacts stored in S3, and scaling via Auto Scaling Groups behind an Application Load Balancer (ALB).  

It reflects industry best practices by separating **application source code** and **infrastructure automation** into distinct repositories.

---

## 🏗️ Architecture
- **Application Repo**: vprofile-app  
  - Contains Java source code and Maven build.   

- **Infrastructure Repo**: aws-deployment  
  - Contains userdata and build scripts.
  - Automates deployment of the app.  

 ### AWS Services Used
- **EC2** → Compute instances running Tomcat  
- **S3** → Artifact storage for WAR files  
- **ALB** → Distributes traffic across EC2 instances  
- **Auto Scaling Group** → Ensures high availability and scalability  
- **Security Groups** → Control inbound/outbound traffic  
- **IAM Roles** → Secure access to S3 and other AWS services  
- **Route 53** → Provides DNS management for private zones, mapping service names (db01, mc01, rmq01) to IP addresses and integrating with Tomcat.


---

## ⚙️ Deployment Workflow
1. Login to AWS Account  
2. Create Key Pairs  
3. Create Security Groups  
4. Launch EC2 Instances with userdata  
5. Update IP-to-name mapping in Route 53 private zone  
6. Build application from source code (Maven WAR)  
7. Upload artifact to S3 bucket  
8. Download artifact to Tomcat EC2 instance  
9. Setup Application Load Balancer (HTTP only for demo; HTTPS with ACM cert is a future improvement)  
10. Use ELB DNS endpoint directly (future improvement: custom domain)  
11. Build Auto Scaling Group for Tomcat instances  
12. Verify deployment end-to-end (app response, scaling behavior, logs)  

---

## 📜 Automation Scripts
- **`build.sh`**  
  Compiles the Java application using Maven and uploads the WAR artifact to an S3 bucket.  
  ### Scripts Overview
  - `build.sh`: Compiles the app and uploads WAR to S3.
  - `deploy.sh`: Installs Tomcat, fetches WAR from S3, deploys it.
