# Week 8 — Serverless Image Processing

Such a challenging week. Plenty of bugs and errors that needs to be fixed. Luckily, I have the time in the weekends to double time on this project. Watched Andrew's CORS videos a couple times each just to get down to it. Asked the Discord group if they can help, even ChatGPT is so helpful.  

This week started with installing AWS CDK (Cloud Development Kit) which is an IaC (Infrastructure as Code) for provisioning and managing cloud resources in an automated and declarative way.  ```npm install aws-cdk -g```  

We also add this on gitpod.yml  
```  - name: cdk
    before: |
      npm install aws-cdk -g 
 ```  
It will then populate this directory.  
<img src="assets/week8-install-cdk.png" alt="After Successful CDK Install">  

We need to run ```cdk bootstrap``` before running ```cdk deploy``` when using the AWS Cloud Development Kit (CDK) for the first time in a new AWS account or region. The cdk bootstrap command sets up the necessary resources, such as an S3 bucket and an Amazon S3 object, that are used for storing the deployment artifacts of your CDK applications. These resources are required for packaging and deploying the CDK application's artifacts during the cdk deploy command.  
<img src="assets/week8-cdk-bootstrap-success.png" alt="cdk bootstrap" width="500">  

CDK Deploy ==>  
<img src="assets/week8-cdk-deploy-success.png" alt="cdk deploy" width="500">  

There's a confirmation message before we can deploy the resources.  
<img src="assets/week8-cdk-deploy-confirm.png" alt="cdk confirmation message" width="500">  

Successful deployment ==>   
<img src="assets/week8-cloudformation-stacks.png" alt="cloudformation successful deployment" width="500">  
<img src="assets/week8-deploy-success.png" alt="cdk deploy success in terminal" width="500">  

We then go proceed and make a bucket for storage of the profile pictures of our users in the app. These photos will be stored in different folders as you can see in the screenshot. You can also see their difference in size. Another folder is also created for the banner photos.  
<img src="assets/week8-original-processed-details.png" alt="difference between original and processed images" width="500">  

A bucket policy is created to perform its task.  
<img src="assets/week8-cloudfront-s3-bucket-policy.png" alt="s3 bucket policy" width="500">  

2 Lambda functions are created to trigger the upload of images and to process them as well.  2 bash files are also created to fasten the testing to see if the lambdas work namely: ```upload``` ```clear```  
<img src="assets/week8-cloudformation-resources-success.png" alt="Stacks Update" width="500">  

An updated profile page with the profile photo and banner.  
<img src="assets/week8-profile-pic-banner.png" alt="updated profile page" width="500">  

An "Edit Profile" button is added on the profile page and here's the code behind it.  
<img src="assets/week8-edit-profile-popup.png" alt="edit profile popup message" width="500">  

When a user wants to edit his bio, we need to store it somewhere. One solution is to include it on the user in our database. Created executable scripts ```bin/db/migrate```, ```bin/db/rollback```  
<img src="assets/wee8-migrations.png" alt="add bio column" width="500">  
<img src="assets/week8-schema-information.png" alt="last successful run" width="500">  
<img src="assets/week8-bin-db-migrate.png" alt="migrate" width="500">  
<img src="assets/week8-not-inserting-twice.png" alt="should not insert twice" width="500">  

Here's the updated Edit Profile button in the app now. Soon, we will add another button to change profile picture.  
<img src="assets/week8-popup-edit-profile.png" alt="Edit Profile" width="500">  

Bio and Display Name shows up in the page.  
<img src="assets/week8-bio-displayname-shows-up.png" alt="bio and display name in the page" width="500">  

What it looks like in the database  
<img src="assets/week8-migration-successful.png" alt="behind the page" width="500">  

To upload the avatars, we will make a POST request to the /avatars/key_upload resource at ```https://<API_ID>.execute-api.<AWS_REGION>.amazonaws.com/```, you can find it in the API Gateway you created. To handle this request, we will create a Lambda function called CruddurAvatarUpload that will decode the URL and process the request. Additionally, we will implement authorization using another Lambda function called CruddurApiGatewayLambdaAuthorizer to control the data that can be transmitted from our gitpod workspace using the APIs.  
<img src="assets/week8-presigned-url.png" alt="presigned url">  
<img src="assets/week8-thunder-client.png" alt="thunder client is the same as postman" width="500">  
<img src="assets/week8-ruby-lambda-function-test-ok.png" alt="lambda function test" width="500">  

I encountered errors on my Lambdas so I asked ChatGPT for advices and it turns out I have to install the aws-jwt-verify in the root directory as well aside from its designated path. I also added this code to my function.rb in CruddurAvatarUpload Lambda.  
<img src="assets/week8-chatgpt-suggestion-to-crudduravatarupload-lambda.png" alt="ChatGPT suggestion" width="500">  
<img src="assets/week8-chatgpt-suggestion-to-install-jwtverify-on-root.png" alt="ChatGPT suggestion 2" width="500">  

In this screenshot, you can see that the new photo is uploaded to the S3 bucket.  The pre-signed URL works.  
<img src="assets/week8-newphoto-uploaded-presignedurl-success.png" alt="presigned url is a success" width="500">  

S3 bucket after a successful upload.  
<img src="assets/week8-my-assets-bucket-after-successful-upload.png" alt="Assets Bucket" width="500">  

When I try to upload a couple times, I noticed that the photo will not automatically change after a refresh. So I read into Discord Week 8 channel and I found out that I need to make an invalidation rule on my Distro in Cloudfront. ```/avatars/*```    
<img src="assets/week8-cloudfront-invalidation-to-not-cache.png" alt="Using the CLI to create ECR" width="500">  
<img src="assets/week8-ChatGPT-suggestion-about-cache-invalidation-rule-cloudfront.png" alt="ChatGPT suggestion" width="500">  



