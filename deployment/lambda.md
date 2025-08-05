## ⚙️ Chapter 5: Lambda Backend Setup

### 5.1 Lambda Function

Our backend is implemented as a **Lambda function** that:

* Connects to the RDS database
* Uses Redis for caching
* Retrieves secrets from SSM

It is deployed in the **private subnet** and connects to the internet through the **NAT Gateway** (if needed for third-party APIs).

### 5.2 IAM Execution Role

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
