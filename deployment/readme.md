# 📘 Deployment TextBook

## 🌐 Chapter 1: VPC and Networking Setup

### 1.1 Create the VPC

We begin by defining our **Virtual Private Cloud (VPC)** to logically isolate our cloud resources.

* **VPC CIDR block:** `10.0.0.0/16`

  * This gives us 65,536 private IP addresses, which is ample for our setup.

### 1.2 Create Subnets

We partitioned the VPC into four subnets:

* **2 Public Subnets** for internet-facing components:

  * `10.0.0.0/24`
  * `10.0.1.0/24`
* **2 Private Subnets** for internal components:

  * `10.0.2.0/24`
  * `10.0.3.0/24`

### 1.3 Create Internet Gateway and NAT Gateway

* **Internet Gateway (IGW):** Associated with the VPC we just created.
* **NAT Gateway:** Placed in one of the public subnets to allow private subnet instances to access the internet without being exposed.

### 1.4 Create Route Tables

We created **two route tables**:

#### Public Route Table

* Associated with the **public subnets**
* Add route:
  * Destination: `0.0.0.0/0` → **Internet Gateway**

#### Private Route Table

* Associated with the **private subnets**
* Add route:
  * Destinationt: `0.0.0.0/0` → **NAT Gateway**

---

## 💾 Chapter 2: Backend Infrastructure

### 2.1 RDS Instance (PostgreSQL)

Before deploying the backend Lambda function, we need a **relational database**:

* **Engine:** PostgreSQL
* **Subnet group:** The RDS instance is deployed in the **private subnets**
* **Access:** Secured by limiting access to Lambda’s security group

Database credentials are **not hard-coded**. Instead, we store them securely using AWS Systems Manager (SSM) Parameter Store.

### 2.2 Redis Instance

We also provision a **Redis cluster** (via Amazon ElastiCache) for in-memory data storage and caching needs.

* **Deployment:** In the private subnets
* **Access:** Only allowed from Lambda or other backend resources via security group rules

---

## 🔐 Chapter 3: Secure Configuration Management

### 3.1 SSM Parameter Store

Secrets like:

* RDS master password (`/ratingo/postgres/master_password`)
* API keys

are stored in **SSM Parameter Store** using `SecureString`. This ensures sensitive data is encrypted at rest.

---

## ⚙️ Chapter 4: Lambda Backend Setup

### 4.1 Lambda Function

Our backend is implemented as a **Lambda function** that:

* Connects to the RDS database
* Uses Redis for caching
* Retrieves secrets from SSM

It is deployed in the **private subnet** and connects to the internet through the **NAT Gateway** (if needed for third-party APIs).

### 4.2 IAM Execution Role

We create a dedicated **Lambda Execution Role** with the following policies:

* **SSM Read Access** for Parameter Store:

```json
{
  "Effect": "Allow",
  "Action": ["ssm:GetParameter"],
  "Resource": "arn:aws:ssm:<region>:<account-id>:parameter/ratingo/postgres/*"
}
```

* Additional permissions (e.g., logging to CloudWatch, access to other AWS services) are added as needed.

---

## 📦 Next Steps
