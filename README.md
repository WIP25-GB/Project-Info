# 🎬 Movie Rating App – Project Overview

A full-stack Movie Rating web application where users can rate and review movies. This app is designed to run on AWS, with an automated deployment pipeline and observability stack.

---

## 🧑‍💻 Application Architecture

```

User
│
▼
Frontend (Web App)

* HTML/CSS/JavaScript
  │
  ▼
  Backend (API - Python)
* Python (Flask/FastAPI)
  │
  ▼
  Database (RDS)
* MySQL or PostgreSQL

```

---

## 🌐 Frontend

- **Stack**: HTML, CSS, JavaScript
- **Hosting**: Amazon EC2 instances (Auto Scaling Group)
- **Access**: Served via Application Load Balancer
- **Responsibilities**: 
  - Movie search
  - Rating submission UI
  - Displaying reviews and scores

---

## 🔧 Backend

- **Language**: Python
- **Framework**: Flask or FastAPI
- **Hosting**: AWS Lambda (Serverless)
- **Responsibilities**:
  - Handle API requests from frontend
  - Connect to RDS for data storage/retrieval
  - Input validation, business logic

---

## 🛢️ Database

- **Engine**: Amazon RDS (MySQL or PostgreSQL)
- **Responsibilities**:
  - Store user data, ratings, and movie metadata

---

## 📊 Observability (Nice-to-Have)

- **Monitoring**: Prometheus
- **Visualization**: Grafana
- **Metrics**: API latency, errors, database response time, frontend uptime

---

## ☁️ AWS Infrastructure (Terraform Managed)

### Core Components

- **VPC**
  - Custom VPC with public and private subnets

- **Subnets**
  - Public: for Load Balancer and frontend EC2s
  - Private: for RDS

- **NAT Gateway**
  - For internet access from private subnets (e.g., RDS init scripts, Lambda egress)

- **Application Load Balancer**
  - To route traffic to the EC2 frontend instances

- **RDS**
  - Hosted MySQL/PostgreSQL instance in a private subnet

- **Lambda**
  - Python backend functions triggered via API Gateway

- **Route53** (Nice-to-Have)
  - Custom domain pointing to the Load Balancer

---

## 🚀 Deployment Strategy

### CI/CD Pipelines

- **AWS CodeBuild**
  - Build frontend assets
  - Package backend code for Lambda
  - Linting, tests, etc.

- **AWS CodeDeploy**
  - Deploy frontend to EC2s
  - Deploy backend to Lambda
  - Update infrastructure using Terraform (optional)

---

## 📦 Repository Structure (Proposed)

```

movie-rating-app/
├── frontend/
│   └── index.html, styles.css, app.js
├── backend/
│   └── main.py, requirements.txt
├── infrastructure/
│   └── terraform/
│       ├── main.tf
│       ├── vpc.tf
│       ├── ec2.tf
│       ├── lambda.tf
│       ├── rds.tf
│       └── variables.tf
├── .gitlab-ci.yml
└── README.md

```

---

## ✅ Next Steps

1. Design the database schema (ratings, users, movies)
2. Create frontend HTML/CSS mockups
3. Build and test Python API locally
4. Write Terraform code for VPC, RDS, Lambda, and EC2
5. Set up CI/CD with CodeBuild and CodeDeploy
6. Optionally add monitoring with Prometheus and Grafana

---

## 📌 Notes

- Use `ALB + ASG` for scalable frontend
- Ensure Lambda has access to the private subnet if needed (via VPC config)
- Secure RDS with security groups and IAM
- Use Secrets Manager or Parameter Store for DB credentials

---

```
