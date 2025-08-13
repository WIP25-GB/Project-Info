# 🎬 Movie Ratings Aggregator – AWS Cloud Architecture

## 📌 Overview

The **Movie Ratings Aggregator** is a cloud-native application that lets users view aggregated ratings from multiple external sources.
It is designed for **scalability, fault tolerance, and secure API integration** using **AWS services**.

---

## 🏗 Architecture Summary

This architecture is split into three main layers: **Frontend**, **Backend**, and **Data Layer**.

---

### **1️⃣ Frontend Layer**

* Built with **React.js**.
* Served from **EC2 instances** in an **Auto Scaling Group**.
* **Nginx** acts as a reverse proxy:

  * Listens on port 80.
  * Serves React static files.
  * Proxies API requests to **Amazon API Gateway**.
* **Amazon Route 53** handles DNS.
* **AWS WAF** provides security filtering.
* **AWS Certificate Manager (ACM)** provides SSL/TLS certificates.

---

### **2️⃣ Backend Layer**

* **Amazon API Gateway** exposes REST endpoints for frontend communication.
* **AWS Lambda Functions** (written in Python) handle business logic.
* Functions query:

  * **TMDB API**
  * **OMDB API**
  * **RDS**
* Responses are cached in **ElastiCache** for performance.

---

### **3️⃣ Data Layer**

The data layer ensures fast access to frequently used data while maintaining a durable and consistent source of truth.

* **Amazon RDS (Multi-AZ)**

  * Stores persistent application data (user data, historical ratings, search logs, etc.).
  * Runs in **private subnets** for security.
  * Configured for **high availability** with Multi-AZ failover.
* **Amazon ElastiCache (Redis)**

  * Acts as an in-memory cache for frequent API responses and query results.
  * Reduces external API calls and speeds up repeated queries.
  * Also deployed in **private subnets**.

---

## 🔄 Request Flow

1. **User** visits the frontend URL (managed by Route 53).
2. **AWS WAF** filters malicious traffic.
3. **Application Load Balancer** routes the request to an EC2 instance.
4. **Nginx** serves React assets or forwards API requests to API Gateway.
5. **API Gateway** triggers the relevant **AWS Lambda**.
6. **Lambda Function**:

   * Checks **ElastiCache** for cached data.
   * If not cached, fetches from **TMDB**/**OMDB** APIs.
   * Stores results in **RDS** for persistence and **ElastiCache** for faster future access.
7. Response is returned to the frontend.

---

## 🛠 Tech Stack

### Frontend

* React.js
* Nginx
* EC2 + Auto Scaling Group

### Backend

* Python (AWS Lambda Functions)
* Amazon API Gateway

### **Data Layer**

* **Amazon RDS (Multi-AZ)** – persistent relational database.
* **Amazon ElastiCache (Redis)** – in-memory caching.

### AWS Infrastructure & Security

* Amazon Route 53
* AWS WAF
* Application Load Balancer
* NAT Gateway
* AWS Certificate Manager (ACM)
* Systems Manager Parameter Store

---

## 📊 Diagram

![Architecture Diagram](deployment/codered.png)

---

## 🔒 Security Considerations

* Database and cache in **private subnets** (no public exposure).
* API keys and DB credentials stored in **Parameter Store**.
* HTTPS enforced with ACM certificates.
* WAF rules against common exploits.
