## ⚙️ Chapter 5: Lambda Backend Setup

### 5.1 IAM Execution Role

We create a dedicated **Lambda Execution Role** that can **read parameters from SSM Parameter Store**.

1. **Log in** to the [AWS Management Console](https://console.aws.amazon.com/).

2. Go to the **IAM** service.

3. In the left menu, click on **Policies**, then click **Create policy**.

4. Choose the **Visual editor** tab (default).

5. In the **Service** section:

   * Click **Choose a service**
   * Search and select **Systems Manager**

6. Under **Actions**:

   * Expand the “Read” section.
   * Check **GetParameter**

7. Under **Resources**:

   * Choose **All resources**

8. Click **Next**.

9. Name the policy, for example:

    ```
    ratingo-lambda-exec-policy
    ```

    Add a description (optional), e.g.:

    ```
    Allows Lambda functions to read parameters from SSM Parameter Store
    ```

11. Click **Create policy**.

12. In the left menu of IAM, click **Roles**, then click **Create role**.

13. Under **Trusted entity type**, choose:

   * **AWS service**

14. Under **Use case**, select:

   * **Lambda**

15. Click **Next**.

16. In the **Permissions policies** step:

   * Search for the policy you just created, e.g., `ratingo-lambda-exec-policy`
   * Select the checkbox next to it.

17. Click **Next**.


18. Enter a **Role name**, e.g.:

     ```
     ratingo-lambda-exec-role
     ```
     
9. Click **Create role**.


### 5.2 Security Group

We create a secuirty group to allows us control what traffic is sent in and out of our lambda functions.

1. Log in to the [AWS Console](https://console.aws.amazon.com/).

2. Navigate to the **EC2** service.

3. In the left menu, click **Security Groups**.

4. Click **Create security group**.

5. Name the security group

    ```
    ratingo-lambda-sg
    ```

    Add a description (optional), e.g.:

    ```
    Security group for ratingo lambda functions
    ```
6. Click **Create security group**