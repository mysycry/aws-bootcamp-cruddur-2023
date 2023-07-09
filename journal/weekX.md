# Week X- Wrap Up  



## Sync Tool for static website hosting

Create a static build bash script file to run ```npm build```. Run it manually in the frontend-react-js path.  

npm build script file should contain these env vars:  
```
REACT_APP_BACKEND_URL="https://api.sample123xxxdomain.com" \
REACT_APP_AWS_PROJECT_REGION="$AWS_DEFAULT_REGION" \
REACT_APP_AWS_COGNITO_REGION="$AWS_DEFAULT_REGION" \
REACT_APP_AWS_USER_POOLS_ID="sample123xxx" \
REACT_APP_CLIENT_ID="sample123xxx" \
REACT_APP_API_GATEWAY_ENDPOINT_URL="https://sample123xxx.execute-api.ca-central-1.amazonaws.com" \
```

Once the static build is done zip the content of the build folder and upload into s3 bucket (cloudmate.tech) use the command ```zip -r build.zip build/``` to zip the contents of the folder build into the folder(frontend-react-js)  
Then download the build.zip into your laptop.  
Upload the files into your s3 bucket.  
For this to work, the bucket name should match the domain URL.  
After uploading, you can now check the domain URL and you can now see the static files.  


Create new bash script file in bin/frontend/sync.  
Install the aws_s3_website_sync using the command ```gem install aws_s3_website_sync``` and ```gem install dotenv```.  
Create a temp directory and create a file .keep use the command ```git add -f temp/.keep```  
Create a file for sync-env to specify the env vars in folder erb ```erb/sync.env.erb``` which will be called later on ```./bin/frontend/sync```  
Run the sync bash script file ```./bin/frontend/sync```.  
We need to attach inline permissions into the created CrdSyncRole in CFN  -getobject,putobject,listbucket,deleteobject  
<img src="journal/assets/weekX-create-new-inline-policy-for-new-role-for-sync.png" alt="CrdSyncRole" width="700">  
<img src="journal/assets/weekX-frontend-sync-success.png" alt="Frontend Sync" width="700">  
<img src="journal/assets/weekX-sync-changeset-yes-output.png" alt="Execute Changeset" width="700">  
Agreeing to execute the plan will upload and delete the changes in your bucket and a Cloudfront Invalidation will be created. Wait for it to finish and check your domain for the changes.  



After any frontend changes in your code, you need to execute all of these again to see the changes in production.  So I test this by making a change in "About" into "About!".  
After editing the frontend code (DesktopSidebar.js), We run ```./bin/frontend/static-build``` to build the new changes then we run the sync tool ruby  file  ```./bin/frontend/sync``` to see the changes. Execute it then after and wait for the Cloudfront Invalidation to finish.  
<img src="journal/assets/weekX-About!.png" alt="About!" width="700">  

## Reconnect Database and Post Confirmation Lambda  

Modify the  CFN stack for the CICD to take ```serviceName:backend-flask```  
Run ```./bin/cfn/cicd```  
In local testing change docker-compose.yaml Dockerfile to Dockerfile.prod for  service: backend-flask  
Then do ```docker compose up```  
Then check the gitpod backend URL/api/activities/home in the browser. You will notice that it throws an error  
So we need to connect to the database by running  ```./bin/db/connect``` to check if it really exist.  
Then we build the backend-flask docker file by running ```./bin/backend/build```
Push the build image to ECR by ```./bin/backend/push```  
Run ```./bin/cfn/service```  then wait for the backend-flask service to be up and running  
Also  change the prod_connection url to newer database from ```cruddur-db-instance``` to ```cruddur-instance```.  
Add an inBound rule to the RDS security group "RDSSG"
Run ```./bin/rds/update-sg-rule``` to update the gitpod ip address CrdDbRDSSG  
Export both DB_SG_RULE_ID and DB_SG_ID  
```
export DB_SG_RULE_ID="sgr-12345678901234567"
gp env DB_SG_RULE_ID="sgr-12345678901234567"
```  

```
export DB_SG_ID="sg-12345678901234567"
gp env DB_SG_ID="sg-12345678901234567"
```
Export the gitpod ip address by running ```curl ifconfig.me```
Now execute script ```./bin/rds/update-sg-rule```  

It should return ```"Return": true```  

Connect to the RDS by running ```./bin/db/connect prod```  
Do a schema-load for the prod by running ./bin/db/schema-load prod  
<img src="journal/assets/weekX-prod-connection-url.png" alt="Schema Load Prod" width="700">  
<img src="journal/assets/weekX-api-domain-working.png" alt="API Domain Working" width="700">  

Override the connection_url to Prod_connectionurl by running ```CONNECTION_URL=$PROD_CONNECTION_URL ./bin/db/migrate```
This will alter the prod table and add a column Bio(text)  

Modify the lambda function ```cruddur-post-confirmation``` to trigger when you signin to the app and changed the connection url in env var from cruddur-db-instance to cruddur-instance.
Create a new security group "CognitoLambdaSG" and it should contain outbound rule with ALLTRAFFIC 0.0.0.0/0 but no inbound rule.  
Then change lambda cruddur-post-confirmation -> configuration -> Change VPC to the new VPC, subnets and sg CognitoLambdaSG.  
Delete the Cognito user in the console and signup again.  
Modify the code in lambda function ```cur.execute(sql,*params)``` to ```cur.execute(sql,params)``` to insert the user data.  
<img src="journal/assets/weekX-new-user-inserted-after-registration-prod.png" alt="User Data inserted" width="700">  
We can now then post a crud.  
<img src="journal/assets/weekX-crudpost-local-successful.png" alt="Crud Post Successful" width="700">  

## Use CORS for Service  

Update the config.toml of the CFN stack aws/cfn/service/config.toml  

```
EnvFrontendUrl = 'https://cloudmate.tech'
EnvBackendUrl = 'https://api.cloudmate.tech'
```
Run ```./bin/cfn/service``` to create the change set  
We can now post crud in the domain.  
<img src="journal/assets/weekX-post-crud-success.png" alt="Domain Crud post Successful" width="700">  

## CICD Pipeline and Create Activity  

Signup with another account in Cruddur and post a crud. Test this alt account with the local postgres db. Run the docker-compose up once it is up and running, seed the data into the local db. by running ```./bin/db/setup```.  Run the script to update the cognito_user_id ```./bin/db/update_cognito_user_ids```  

## Refactor to use JWT Decorator in Flask App  

Edit  replyform.js to close the reply_popup onclick. Create a decorator that will handle JWT verification Modify the code in app.py in backend-flask/app.py and backend-flask/lib/cognito_jwt_token.py once it is done check the frontend app is working as expected.  

## Refactor app.py  
Refactoring is the process of restructuring code, while not changing its original functionality. The goal of refactoring is to improve internal code by making many small changes without altering the code's external behavior.  
By creating separate python files for the honeycomb, xray, cloudwatch, cors, rollbar etc. we made the whole codebase more understandable and easy to navigate.  

## Refactor Flask Routes  
Creating separate python files for the routes based on activities, messages, general and users and import the files and load the route in the appy.py.  

## Implement Replies for Posts  
Make sure that ```reply_to_activity_uuid``` is set to "string"  in the db schema by running the script  ```./bin/generate/migration reply_activity_uuid_to_string```.  
Run migrate to alter table with field reply_to_activity_uuid to convert type integer to uuid.  
Double-check by connecting to the database from the terminal.  
You can also aanually update the activities table to drop the column reply_to_activity_uuid and add a cloumn 'reply_to_activity_uuid as uuid` by running the command:  
```
ALTER TABLE activities DROP COLUMN reply_to_activity_uuid;
ALTER TABLE activities ADD COLUMN reply_to_activity_uuid uuid;
```
Double check the database and check the logs for errors.  

## Activitiy Show Page  

Change the display name and handler from div to links, also change the text decoration and underline for the display name and handler in the files. They can be found in ActivityContent.js and ActivityContent.css  

## Cleanup  

Insert other user values into the seed.sql manually by using the connect to rds script ```./bin/db/connect```
```
INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'mysycry' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  ),
  (
    (SELECT uuid from public.users WHERE users.handle = 'josiasmichael2' LIMIT 1),
    'I am the other!',
    current_timestamp + interval '10 day'
  );
```

Implement ⬅ back button on the "frontend-react-js/src/pages/ActivityShowPage.js" and styling on "frontend-react-js/src/pages/ActivityShowPage.css"  
```
	const navigate = useNavigate();
	const goBack = () => {
		navigate(-1);
	}
```
Ask for a new pull request to merge main  to prod branch and if there are any merge conflicts resolve them. After merge request is confirmed a codepipeline will be triggered. Make sure that the codepipeline is ran successfully.  
<img src="journal/assets/weekX-cicd-pipeline-success.png" alt="CICD Pipeline Success" width="700">  


### Messaging  

Modify the Dynamodb table name in the "CFN Service".  

=aws/cfn/service/template.yaml  
=aws/cfn/service/config.toml  
=backend-flask/lib/ddb.py  
=erb/backend-flask.env.erb  
Then run ```./bin/cfn/service```  
Update Task-definition with latest changes for the DynamoDB table

Write a new CFN template to create a user with permission to write and read to dynamodb.  

```
AWSTemplateFormatVersion: '2010-09-09'
Resources:
  CruddurMachineUser:
    Type: 'AWS::IAM::User'
    Properties: 
      UserName: 'cruddur_machine_user'
  DynamoDBFullAccessPolicy: 
    Type: 'AWS::IAM::Policy'
    Properties: 
      PolicyName: 'DynamoDBFullAccessPolicy'
      PolicyDocument:
        Version: '2012-10-17'
        Statement: 
          - Effect: Allow
            Action: 
              - dynamodb:PutItem
              - dynamodb:GetItem
              - dynamodb:Scan
              - dynamodb:Query
              - dynamodb:UpdateItem
              - dynamodb:DeleteItem
              - dynamodb:BatchWriteItem
            Resource: '*'
      Users:
        - !Ref CruddurMachineUser
```
In the IAM console, generate the secret credentials for the machine user and update them in the ssm Parameter store in "/cruddur/backend-flask/AWS_ACCESS_KEY_ID" and "/cruddur/backend-flask/AWS_SECRET_ACCESS_KEY".  
You need to update both or else you will face some issues.  

<img src="journal/assets/weekX-machineuser-stack-iam-machineuser-user.png" alt="Machine User Stack" width="700">  

Then create a new pull request from the main to prod. Create a new pull request from prod to week-x-again and the pipeline should work successfully.  
<img src="journal/assets/weekX-cicd-pipeline-success.png" alt="CICD Pipeline Success" width="700">  

Go to the domain login and send a message to the other user.  
<img src="journal/assets/weekX-messaging-works.png" alt="Messaging Success" width="700">  
<img src="journal/assets/weekX-shows-the-messages.png" alt="Message List Shows" width="700">  
Sent messages should be sent to the DynamoDb table created by CFN DDb stack.  


## And Beyond

We have 2 users right now in my app. Then when I use my alt account,and click on Profile tab, it will still route me to my main.  
I fixed this by editing "DesktopNavigation.js":
```
    profileLink = <DesktopNavigationLink 
    url="/@mysycry"
```
from hardcoding the username path, i changed it to:  
```
    profileLink = <DesktopNavigationLink 
    url={`/@`+props.user.handle}
```

I also get issues with updating the profile picture and bio. Fixing this by:  
-updating users.py app.route from POST to PUT  
```@app.route("/api/profile/update", methods=['PUT','OPTIONS'])```  
-passing the env var (REACT_APP_API_GATEWAY_ENDPOINT_URL)' into the static-build file where we passed all other env vars to the frontend app.  
-changing the "Access-Control-Allow-Origin":  in Lambda(cruddurAvatarUpload) to production url like "https://cloudmate.tech"  
-changing bucket CORS permission that handles the uploaded assets/files.  
-push the backend changes by running the script `./bin/backend/build and ./bin/backend/push'  
-head to ECS in the AWS Console and stop the task, it will then create a new task with the changes we made.  

Test by going to the domain URL and click on "Edit Bio" and upload a new photo and Bio message.  
<img src="journal/assets/weekX-change-bio-profilepic-success.png" alt="Edit Profile Success" width="700">  
