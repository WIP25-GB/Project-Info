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

8. Click Add more permissions
    **Service:** **CloudWatch Logs**
    **Actions allowed:** search and select **CreateLogGroup**, **CreateLogStream** and **PutLogEvents**
    **Resources:** **All**

9. Click Add more permissions
    **Service:** **S3 Object Lambda**
    **Actions allowed:** search and select **WriteGetObjectResponse**
    **Resources:** **All**

10. Click Add more permissions
    **Service:** **EC2**
    **Actions allowed:** search and select **CreateNetworkInterface**, **DescribeNetworkInterfaces** and **DeleteNetworkInterface**
    **Resources:** **All**

11. Click **Next**.

12. Name the policy, for example:

    ```
    ratingo-lambda-exec-policy
    ```

    Add a description (optional), e.g.:

    ```
    Allows Lambda functions to read parameters from SSM Parameter Store
    ```

13. Click **Create policy**.

14. In the left menu of IAM, click **Roles**, then click **Create role**.

15. Under **Trusted entity type**, choose:

   * **AWS service**

16. Under **Use case**, select:

   * **Lambda**

17. Click **Next**.

18. In the **Permissions policies** step:

   * Search for the policy you just created, e.g., `ratingo-lambda-exec-policy`
   * Select the checkbox next to it.

19. Click **Next**.


20. Enter a **Role name**, e.g.:

     ```
     ratingo-lambda-exec-role
     ```

21. Click **Create role**.


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


### 5.4: Creating a Lambda Functions (Now playing)

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

4. Click Create function

5. **Upload function code:**

   * Download the [function zip file](https://github.com/WIP25-GB/ratingo-backend/blob/main/lambdas/now-playing/Archive.zip)
   * Scroll to the **Code** section
   * Click **Upload from → .zip file**
   * Upload the `.zip` file for `ratingo-now-playing`, downloaded from your repository:

6. **Deploy the function:**

   * Once uploaded, click **Deploy** to finalize the changes.

7. **Attach the layer:**

   * Scroll to the **Layers** section (below the code editor)
   * Click **Add a layer**
   * Choose **Custom layers**
   * Select the layer you just created (`psycopg2-layer`)
   * Select **Version 1**, then click **Add**

8. **Add environment variables:**
   * Go to the **Configuration** section
   * Select **Environment variables** from the left pane
   * Click on edit and then click on **Add environment variable
   * Add the following environment variables;
    * omdb_api_key: Value should be the path to the omdb api key in paramater store eg `/ratingo/ext_api/omdb_api_key`
    * omdb_endpoint: Value is `http://www.omdbapi.com`
    * postgres_dbname: Value is the name of the database inside your rds instance eg `ratingo`
    * postgres_host: Value is the endpoint of your rds instance eg `ratingo-db.cazcwami43fp.us-east-1.rds.amazonaws.com`
    * postgres_pasword: Value should be the path to the postgres user password in paramater store eg `/ratingo/postgres/master_password`
    * postgres_port: Value is `5432`
    * postgres_user: Value is the master user from your rds instance eg `ratingo`
    * tmdb_api_key: Value should be the path to the tmdb api key in paramater store eg `/ratingo/ext_api/tmdb_api_key`
    * tmdb_cache_key: Value is `tmdbnowplaying-page`
    * tmdb_endpoint: Value is `https://api.themoviedb.org/3`
    * tmdb_path_now_playing: Value is `movie/now_playing`
    * valkey_host: Value is the endpoint of your valkey instance eg `ratingo-valkey-instance-ddkahn.serverless.use1.cache.amazonaws.com`
    * valkey_port: Value is `6379`
    * valkey_ttl: Value is `1209600`

9. **Configure Runtime settings**
    * Scroll to the runtime settings
    * Click Edit and change the **Handler** to `main.now_playing`

### 5.5: Creating a Lambda Functions (Top rated)

1. **Go to Lambda > Create Function**

2. **Choose “Author from scratch”**

   * **Function name:** `ratingo-top-rated`
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

4. Click Create function

5. **Upload function code:**

   * Download the [function zip file](https://github.com/WIP25-GB/ratingo-backend/blob/main/lambdas/top-rated/Archive.zip)
   * Scroll to the **Code** section
   * Click **Upload from → .zip file**
   * Upload the `.zip` file for `ratingo-top-rated`, downloaded from your repository:

6. **Deploy the function:**

   * Once uploaded, click **Deploy** to finalize the changes.

7. **Attach the layer:**

   * Scroll to the **Layers** section (below the code editor)
   * Click **Add a layer**
   * Choose **Custom layers**
   * Select the layer you just created (`psycopg2-layer`)
   * Select **Version 1**, then click **Add**

8. **Add environment variables:**
   * Go to the **Configuration** section
   * Select **Environment variables** from the left pane
   * Click on edit and then click on **Add environment variable
   * Add the following environment variables;
    * omdb_api_key: Value should be the path to the omdb api key in paramater store eg `/ratingo/ext_api/omdb_api_key`
    * omdb_endpoint: Value is `http://www.omdbapi.com`
    * postgres_dbname: Value is the name of the database inside your rds instance eg `ratingo`
    * postgres_host: Value is the endpoint of your rds instance eg `ratingo-db.cazcwami43fp.us-east-1.rds.amazonaws.com`
    * postgres_pasword: Value should be the path to the postgres user password in paramater store eg `/ratingo/postgres/master_password`
    * postgres_port: Value is `5432`
    * postgres_user: Value is the master user from your rds instance eg `ratingo`
    * valkey_host: Value is the endpoint of your valkey instance eg `ratingo-valkey-instance-ddkahn.serverless.use1.cache.amazonaws.com`
    * valkey_port: Value is `6379`

9. **Configure Runtime settings**
    * Scroll to the runtime settings
    * Click Edit and change the **Handler** to `main.top_rated`

