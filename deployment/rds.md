# 📘 Deployment TextBook

## 💾 Chapter 2: RDS Instance (PostgreSQL)

### 2.1 
Before deploying the backend Lambda function, we need a **relational database**:

* **Engine:** PostgreSQL
* **Subnet group:** The RDS instance is deployed in the **private subnets**
* **Access:** Secured by limiting access to Lambda’s security group

Database credentials are **not hard-coded**. Instead, we store them securely using AWS Systems Manager (SSM) Parameter Store.
