## 🔐 Chapter 4: Secure SSM Parameter Store

### 4.1 

Secrets like:

* RDS master password (`/ratingo/postgres/master_password`)
* API keys

are stored in **SSM Parameter Store** using `SecureString`. This ensures sensitive data is encrypted at rest.
