# CloudNotes – Highly Available Cloud-Native Application

## Case Study

Design and Deployment of a Highly Available, Multi-Tier Cloud-Native Application using the AWS Well-Architected Framework.

## Project Overview

CloudNotes is a cloud-native notes management application designed using a highly available multi-tier AWS architecture.

Users can create, view and delete notes through a web interface. The application uses Node.js and Express for the backend and MySQL for persistent data storage.

## Technology Stack

- Frontend: HTML5, CSS3, JavaScript
- Backend: Node.js, Express.js
- Database: Amazon RDS MySQL
- Containerization: Docker
- Infrastructure as Code: Terraform
- Cloud Platform: Amazon Web Services (AWS)
- Load Balancing: Application Load Balancer
- Compute: Amazon EC2 Auto Scaling
- Networking: Amazon VPC
- Monitoring: Amazon CloudWatch
- Source Control: GitHub

## AWS Architecture

Internet
↓
Application Load Balancer
↓
EC2 Auto Scaling Group
↓
Node.js + Express + Docker
↓
Amazon RDS MySQL

The application is distributed across two Availability Zones to improve availability and fault tolerance.

## AWS Components

### Amazon VPC
Provides isolated networking for the application.

### Application Load Balancer
Distributes incoming HTTP traffic across multiple EC2 instances.

### EC2 Auto Scaling
Maintains multiple application instances and provides automatic scaling.

### Amazon RDS
Provides managed MySQL database storage.

### IAM
Provides secure permissions for EC2 resources.

### CloudWatch
Provides monitoring and operational visibility.

### Terraform
Automates AWS infrastructure deployment.

## High Availability

The application uses:

- Two Availability Zones
- Two EC2 application instances
- Application Load Balancer
- Auto Scaling Group
- Multi-AZ RDS configuration

This architecture reduces the impact of individual instance or Availability Zone failures.

## AWS Well-Architected Framework

### Operational Excellence
Terraform infrastructure automation and CloudWatch monitoring.

### Security
IAM roles, private application/database subnets and security groups.

### Reliability
Multi-AZ deployment, Application Load Balancer and Auto Scaling.

### Performance Efficiency
Load balancing and horizontally scalable EC2 instances.

### Cost Optimization
Small instance sizes and Auto Scaling are used for the academic deployment.

### Sustainability
Resources are appropriately sized and can scale according to demand.

## Repository Structure

```text
202501200100002_RuchiSirohi/
├── Application/
├── Infrastructure/
├── Architecture/
├── Screenshots/
├── Case_Study_Report.pdf
└── README.md