# Week 6 — Deploying Containers

All are in Week 6 journal. Week 7 Journal is empty.
Watched all videos related to week 6-7 on the Exampro channel and the bootcamp playlist.

 We test the RDS connection first. Make sure its returns a success. This is the script and I chmod u+x so that it is executable.  
 ```sh
 #!/usr/bin/env python3

import psycopg
import os
import sys

connection_url = os.getenv("CONNECTION_URL")

conn = None
try:
  print('attempting connection')
  conn = psycopg.connect(connection_url)
  print("Connection successful!")
except psycopg.Error as e:
  print("Unable to connect to the database:", e)
finally:
  conn.close()
  ```  
  It returns:  
<img src="assets/week6-test-connection-successful.png" alt="test-connection-successful" width="500">

Export the env vars before starting and use the ECR CLI command to log-in.  
```sh
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"
```  
Screenshot of exporting env vars and logging in via CLI:  
<img src="assets/week6-ecr-login-via-cruddur-success.png" alt="login and export" width="500">  

I used the CLI to create an ECR image.I tag them as latest and push them  
<img src="assets/week6-cruddur-python-ecr-success.png" alt="Using the CLI to create ECR" width="500">  


After creating the containers, run them using this command e.g. frontend-react-js image  
```sh
docker run --rm -p 3000:3000 -it frontend-react-js 
```  
I then check the task inside and its health  
<img src="assets/week6-running-task.png" alt="Running Task" width="500">  
<img src="assets/week6-task-health-status-check.png" alt="backend Task Health Check" width="500">  
Frontend task:  
<img src="assets/week6-frontend-health-check.png" alt="Frontend Task Health Check" width="500">  

I get inside the container shell using this command. That task number is unique to mine. so you need to change yours.  
<img src="assets/week6-binbash-container-successful.png" alt="Get inside the container shell" width="500">  
I then run the health-check from the inside.  
<img src="assets/week6-health-check-running.png" alt="Health Check from the inside" width="500">  

I tested the IP:4567/api/health-check and it's returns OK  
<img src="assets/week6-api-healthcheck-url-OK.png" alt="API Healthcheck OK" width="500">  

Healh-check using the ALB endpoint  
<img src="assets/week6-health-check-load-balancer.png" alt="ALB health-check" width="500">  
Backend:  
<img src="assets/week6-cruddur-alb-backend-health-check.png" alt="BAckend ALB Health-check" width="500">  

I have 2 services in ECS one for frontend and one for backend.  
<img src="assets/week6-2services-in-ECS.png" alt="ECS 2 Services" width="500">  

Target Groups all Healthy  
<img src="assets/week6-target-groups-all-healthy.png" alt="2 target groups" width="500">  

Frontend ALB Working  
<img src="assets/week6-frontend-backend-all-working-alb.png" alt="frontend ALB working" width="500">  

Backend ALB Working  
<img src="assets/week6-backend-url-working-alb.png" alt="backend ALB working" width="500">  

Hosted Zone and Records request. It costs 0.50cents per hosted zone and it took a few minutes before it passes the validation for the records.  
<img src="assets/week6-hosted-zones-request-validation.png" alt="Hosted Zone and Records" width="500">  

Forwarding Rules added  
<img src="assets/week6-added-forwarding-rules.png" alt="Forwarding Rules" width="500">  

Backend health-check using the domain I bought  
<img src="assets/week6-api-cloudmate-tech-healthcheck-success.png" alt="backend health-check on domain URL" width="500">  

Domain Backend URL  
<img src="assets/week6-backend-api-url-success.png" alt="Backend URL" width="500">  

Back to Local, debugging Flask  
<img src="assets/week6-debugging-flask.png" alt="debugging flask" width="500">  

Bayko Short URL page using my Domain  
<img src="assets/week6-bayko-short.png" alt="Bayko short domain URL" width="500">  
<img src="assets/week6-bayko-short-200.png" alt="bayko short returns 200" width="500">  

Created backend env vars  
<img src="assets/week6-env-vars-generated.png" alt="backend env vars " width="500">  

Configured task definitions to add Xray  
<img src="assets/week6-xray-deploy-ecs.png" alt="Xray on Tasks" width="500">  

Tested locally after passing env vars, App works perfectly.  
<img src="assets/week6-app-working-perfectly-after-passing-env-vars.png" alt="App works perfectly after passing env vars" width="500">  

