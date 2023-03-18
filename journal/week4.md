# Week 4 — Postgres and RDS


i watched and followed the additional videos after the livestream. Rewatched multiple times because of thousands of errors. Successfully overcame them all. Very challenging yet FULFILLING week.

I created a RDS Postgres Instance via terminal. Official documentation on this link:  
[AWS RDS CLI create-database docs](https://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html)   


i bash script inside the db shell and perform some actions and showing off the database explorer successful localhost connection on the left panel  
![Script Inside the Database](assets/week4-database-explorer-postgres-bash.png)  


setting env var in backend  
```py
backend-flask:
    environment:
      CONNECTION_URL: "${CONNECTION_URL}"
```
I have an executable file to setup the database(provided screenshot not yet the prod)  
![Script DB Setup](assets/week4-bin-db-setup.png) 

More executable files  
![More exe files](assets/week4-database-files-added.png)  

Hardcoded posts working  
![Query working](assets/week4-query-working.png) 

I auto-update security group rules by inserting this to the CLI
![AWS CLI to auto-update SGR](assets/week4-script-to-auto-update-SGR.png)  

Multiple tries to register and unregister the user  
![Multiple tries](assets/week4-delete-add-user-on-user-pool-in-cognito.png)  


I have deployed a Lambda function to confirm user information after app registration  
![Lambda Code Deploy](assets/week4-lambda-code-deploy.png) 

Cloudwatch logs capture the information from the registration  
![Cloudwatch Logs](assets/week4-lambda-logs-on-cloudwatch.png) 

I tested registering an existing user  
![Tested registering an existing user](assets/week4-tried-registering-an-existing-user.png)  

Backend logs now with zero errors  
![Logs with no errors](assets/week4-backend-logs-success-no-errors.png)  

Registered User posts finally shows up   
![Registered User posts](assets/week4-cruddur-post-successful.png) 




i register users in Cruddur and they will be inserted into the database  
![User info Captured and inserted into the database](assets/week4-added-user-on-postgres-after-12hrs.png)  
![User data in database](assets/week4-database-files-added.png)   


i post on Cruddur and those will be inserted into the database  
![User posts inside the database](assets/week4-create-new-activities-with-a-database-insert.png) 


