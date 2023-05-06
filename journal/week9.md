# Week 9 — CI/CD with CodePipeline, CodeBuild and CodeDeploy  

I started the week with an error in my Gitpod when I compose up. After investigating, I found out that @app.before_first_request has been removed from flask. Workaround is to replace it with ```with app.app_context():``` in app.py file.  
<img src="assets/week9-Flask-2.3.0-update.png" alt="Flask 2.3.0 Update" width="700">  
Another issue is that the frontend and backend ports are on "Detecting.....". Fellow bootcampers found a workaround to access the page:  

```sh
gp preview $(gp url 4567) --external
gp preview $(gp url 3000) --external
```  

We need to make a ```prod``` branch and that's where we merge the new commits from main to trigger the CodePipeline.  

We need to create a ```backend-flask/buildspec.yml``` first. Also make ```ecr-codebuild-backend-role.json``` for a successful building. I have this error when I don't have that policy yet.  
<img src="assets/week9-phase-details-of-a-failed-build.png" alt="Failed Build" width="700">  
After adding the policy. Build 13 succedded.  
<img src="assets/week9-codebuild-success.png" alt="Successful Build" width="700">  
What does the policy looks like?  
<img src="assets/week9-added-policy-on-bake-image-role.png" alt="Inline Policy Code" width="700">  

# AWS CodeBuild  

Create a ```cruddur-backend-flask-bake-image```.  

Source provider will be Github, repository is my ```mysycry/aws-bootcamp-cruddur-2023```. set source version to ```prod```. After a pull request, the build will be automatically triggered as you can see in this screenshot.  
<img src="assets/week9-source-stage-review.png" alt="Source" width="700">  

Then I have this error in CodeBuild, then after an investigation, all I need to do is to raise a ticket to AWS Support and ask for an increase in concurrent build. In less than 24hrs, they responded and they ask for my region and how many builds. I told them 20. They then work on it, then after a day, they inform me that the engineers are done with my request.  
<img src="assets/week9-cannot-have-more-than-0-builds-in-queue-for-the-account.png" alt="Zero Concureent Builds" width="700">  

In the Environment of the Build, create a new role automatically named as ```codebuild-cruddur-backend-flask-bake-image-service-role```  
and decrease timeout to 20 min, don't select any certificate nor a VPC, select compute as 3 GB memory and 2 vCPUs  

Buildspec file is ```backend-flask/buildspec.yml```  
<img src="assets/week9-in-progress-after-pull-request-granted.png" alt="codebuild" width="700">  

# AWS CodePipeline  

Pipeline name is ```cruddur-backend-fargate```. Source stage is GitHub (Version 2), click "Connect to GitHub", set connection name as ```cruddur```, install a new app, select the cruddur repo, in the end finish "Connect to GitHub" and back to the pipeline page.  
Select the cruddur repo and select branch prod, select "start the pipeline on source code change" and default output artifact format.  
For build stage, select ```AWS CodeBuild``` as build provider, select your region, select the newly created project ```cruddur-backend-flask-bake-image```.  
For deploy stage: select ```ECS``` as deploy provider, choose cruddur cluster, backend-flask service.  

# Testing  

Edit some codes in Gitpod then commit them. Create a pull request and merge the main branch to the prod branch. It will then trigger the Code Pipeline.  
<img src="assets/week9-create-pull-request.png" alt="Pull Request" width="700">  

Below screenshot shows a successful pipeline.  
<img src="assets/week9-codepipeline-success.png" alt="Successful Pipeline" width="700">  
The Build Logs:  
<img src="assets/week9-build-logs.png" alt="cdk deploy" width="700">  
I updated the health-check in my repo and merge the changes to prod, triggered the pipeline, went successful.  
<img src="assets/week9-api-health-check.png" alt="API health-check" width="700">   
