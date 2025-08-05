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
