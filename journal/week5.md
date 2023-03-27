# Week 5 — DynamoDB and Serverless Caching

I watched all the videos for Week 5 DynamoDb and all its supplementary videos. Encountered a lot of errors but the Discord group are full of helpful people and I get my errors fixed.

I created a schema-load script, seed script, scan script, pattern scripts, update cognito ID script.
I then run them on this sequence:  

```js
./bin/db/setup
./bin/db/update_cognito_user_ids
./bin/ddb/schema-load
./bin/ddb/seed
./bin/ddb/patterns/get-conversation
./bin/ddb/patterns/list-conversations 
```

I connect to local database from the terminal  
![Connect to local database from the terminal](assets/week5-getting-user-information-from-db.png) 


I list the conversation by running ./bin/ddb/patterns/list-conversation
![List the conversation](assets/week5-conversation-ddb-success.png)  

Added email on seed.sql
![Added email on seed.sql](assets/week5-added-email-on-seed-sql.png)  

List users in Cognito
![List users in Cognito](assets/week5-list-users-from-cognito-in-terminal.png)  

Update cognito user ids  
![update cognito](assets/week5-execute-update-cognito-user-ids.png)  

Query Select * from USERS; in the local database  
![Query users](assets/week5-select-all-from-users-in-terminal.png)  

Added Londo Mollari  
![Londo is here](assets/week5-londo-mollari-inserted.png)  

Sending message a success but 500 error in the app for message group. Adding "return model" in the mesage_group.py solved the problem
![500 error in the app](assets/week5-sending-message-success-but-500-error.png)  

Replaced Andrew Brown with mine in the database and updated the cognito user ids
![cognito user ids](assets/week5-update_cognito_user_ids.png)  

Messages finally appears. Can send as well
![Query users](assets/week5-messages-appear.png)  

Started a conversation with Londo
![Londo New Conversation](assets/week5-sent-londo-a-message-to-start-a-new-conversation.png)  

VPC Endpoint created
![VPC Endpoint created](assets/week5-vpc-endpoint-created.png)  

Sending message in the prod
![Sending message in the prod](assets/week5-message-bayko-on-prod-success.png)  

Sending message to Londo in the prod
![Sending message to Londo in the prod](assets/week5-message-londo-on-prod-success.png)  

Inline policy for DynamoDb Stream
![Inline policy for DynamoDb Stream](assets/week5-created-an-inline-policy-for-dynamodb-stream-for-messages.png)  

Cloudwatch logs after sending a message
![Cloudwatch logs after sending a message](assets/week5-checked-cloudwatch-logs-for-dynamodb-stream.png)  

