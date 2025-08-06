## ⚙️ Chapter 6: API Gateway

### 6.1 Create API Gateway

We are creating the API Gateway to serve as a single entry point that securely invokes our Lambda functions via HTTP requests.

1. **Log in** to the [AWS Management Console](https://console.aws.amazon.com/).

2. Go to API Gateway > Create API

3. Select **HTTP API**

4. Provide a name. eg `ratingo-apigateway`

5. Add Integration
    * Choose Add integration > Lambda function

    * Select the first Lambda function `ratingo-now-playing`

6. Add another Integration
    * Choose Add integration > Lambda function

    * Select the second Lambda function `ratingo-top-rated`

7. Configure Routes
    * Add a route **ANY /playing** for the first lambda function
    * Add a route **ANY /rating** for the second lambda function 

8. Deploy the API

9. Configure CORS
    * Click on CORS on the left panel
    * Add `*` to the **Access-Control-Allow-Origin** field
    * Save
