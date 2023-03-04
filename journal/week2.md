# Week 2 — Distributed Tracing

I attended the livestream and I love this week's guests. Full of insights on the topic. The students are attentive as well.  

I watch the new videos uploaded on the YT playlist.  

I also added AWS Xray SDK on requirements.txt and app.py.  
I also added Deamon Service to Docker Compose.

I added Honeycomb on requirements.txt and app.py. I then installed the dependencies

I added env vars on docker-compose  
```
OTEL_EXPORTER_OTLP_ENDPOINT: "https://api.honeycomb.io"
OTEL_EXPORTER_OTLP_HEADERS: "x-honeycomb-team=${HONEYCOMB_API_KEY}"
OTEL_SERVICE_NAME: "${HONEYCOMB_SERVICE_NAME}"
```
I added Watchtower and Rollbar on requirements.txt and app.py.   

I made an AWS Xray groupname via AWS CLI  
![Xray groupname](assets/week2-error-in-aws-xray-cli-resolved.png)  

Daemon Logs sent:
![Daemon Logs](assets/week2-daemon-logs.png)  

Xray traces on my AWS Console
![xray traces on my AWS Console](assets/week2-xray-traces-on-console.png)  


Log Group Events  
![Cloudwatch log group events](assets/week2-cloudwatch-logevents-from-loggroups-testlog.png)  

Rollbar sending data
![Rollbar sending data](assets/week2-rollbar-sending-data.png)  

Commenting out week2-tracing codes on my repo to avoid being charged eventho the free tier on services are generous enough to give a big amount to work with.  
![Commenting Out codes](assets/week2-commenting-out-xray-cloudwatch-spend-concern.png)  
