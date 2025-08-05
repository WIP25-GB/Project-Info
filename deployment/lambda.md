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


### 5.3: Creating a Lambda Layer

We create a lambda layer for the psycopg python library 

1. **Click to create a new Lambda layer:**

   * Go to the **Lambda** section of the AWS Console.
   * In the left menu, click **"Layers"**
   * Click **"Create layer"**

2. **Download the layer package:**

   * Download the [psycopg2-layer.zip file](https://github.com/WIP25-GB/ratingo-backend/blob/main/lambdas/layers/psycopg2-layer/psycopg2-layer.zip)

3. **Fill in layer details:**

   * **Name:** `psycopg2-layer`
   * **Upload ZIP file**: Choose the `.zip` file you downloaded.
   * **Compatible runtimes:** Select **Python 3.12**
   * **Compatible architectures: Select **arm64**
   * Click **Create**


### 5.4: Creating a Lambda Functions

1. **Go to Lambda > Create Function**

2. **Choose “Author from scratch”**

   * **Function name:** `ratingo-now-playing`
   * **Runtime:** `Python 3.12`
   * **Architecture:** `ARM 64`
   * **Execution role:**

     * Choose **Use an existing role**
     * Select the previously created role (e.g., `ratingo-lambda-exec-role`)

3. **Configure VPC access:**

   * Expand the **Advanced settings**
   * Select the VPC you created earlier
   * Choose **both private subnets**
   * Choose the  security group created in point 5.2

4. **Upload function code:**

   * Download the [function zip file](https://github.com/WIP25-GB/ratingo-backend/blob/main/lambdas/now-playing/Archive.zip)
   * Scroll to the **Code** section
   * Click **Upload from → .zip file**
   * Upload the `.zip` file for `ratingo-now-playing`, downloaded from your repository:

5. **Attach the layer:**

   * Scroll to the **Layers** section (below the code editor)
   * Click **Add a layer**
   * Choose **Custom layers**
   * Select the layer you just created (`psycopg2-layer`)
   * Select **Version 1**, then click **Add**

6. **Deploy the function:**

   * Once uploaded, click **Deploy** to finalize the changes.

7. Follow same steps to deploy `Top rated function` found [here]()