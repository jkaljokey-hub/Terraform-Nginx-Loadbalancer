# 🏗️ Project Overview

This project demonstrates how to deploy a Linux-based NGINX Load Balancer on Microsoft Azure using the Azure Portal, distributing traffic across multiple backend web servers.
It follows a real-world architecture used in production environments.

 ## 📊 Architecture Diagram

![ERP Azure Architecture](https://github.com/jkaljokey-hub/Terraform-Nginx-Loadbalancer/blob/master/assert/Copilot_20260419_063348.png?raw=true)



## The setup includes:

1 NGINX Load Balancer VM (Ubuntu)

2 Backend Web Server VMs (Ubuntu + NGINX)

Private VNet + Subnet

Round‑robin load balancing

Static website content served from /var/www/html

@@ 📦 Architecture Diagram
(Shown in the image above)

Flow:
Internet → Public IP → NGINX Load Balancer → Backend VM1 / Backend VM2
## 🚀 Deployment Steps
### 1. Create Resource Group
Azure Portal → Resource Groups → Create
Name: nginx-rg

### 2. Create Virtual Network
Name: nginx-vnet

Address space: 10.0.0.0/16

Subnet: 10.0.1.0/24

### 3. Deploy Backend VM1
Name: backend-1

Image: Ubuntu 22.04

Public IP: None

VNet: nginx-vnet

Subnet: nginx-subnet

SSH into backend-1:

command:
sudo apt update -y
sudo apt install nginx -y
echo "<h1>Backend 1 - $(hostname)</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx

## 4. Deploy Backend VM2
Repeat the same steps:

bash

sudo apt update -y
sudo apt install nginx -y
echo "<h1>Backend 2 - $(hostname)</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart nginx

### 5. Get Backend Private IPs
Azure Portal → VM → Networking
Example:

backend-1 → 10.0.1.4

backend-2 → 10.0.1.5

### 6. Deploy Load Balancer VM
Name: nginx-lb

Public IP: Yes

Same VNet + Subnet

SSH into the LB VM:

bash
sudo apt update -y
sudo apt install nginx -y

### 7. Configure NGINX Load Balancer

sudo nano /etc/nginx/sites-available/default

