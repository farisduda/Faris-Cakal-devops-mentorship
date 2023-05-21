Architecture deep dive part 1 

- Explaining differencies between monolith and tieed architecture. 
Tiered architecture is better solution were we have coupled tier's then in Monolith infrastructure where storage, load and processing depends on each other. 
In tiered architectire there was used example with ALB to scale the processing part. 
In that example we have HA for processing part. If one of the instances fails laod balancer moves processing to another instances which is healthy.

Architecture deep dive part 2 

- Explanining how we can use SQS service and Auto scalling groups (ASG) to decouple tiers used in this example where we upload pictures and video.

Using a queue architecture by placing a queue in between two applications tiers, decouples those tiers. One tier adds jobs to the queue and it doesn't care about the health or the state of the other and another tier can read jobs from that queue and it doesn't care how they got there.

By using the queue architecture, no communication happens directly. The components are decoupled, the components can scale independently and freely and in this case the processing tier which uses a worker-fleet architecture, it can scale anywhere from zero to a near infinite number. Using Auto scalling group number of instances for processing jobs increase or decrease depends on jobs stacked in queues.

The microservice architecture is a collection of microservices - that do individual things very well, for example - process, upload, store and manage microservices.

Event-Driven Architectures are just a collection of events producers which might be components of your application which directly interact with customers or they might be parts of your infrastructure such as EC2, or they might be systems monitoring components.

Best practice Event-Driven Architectures have what's called an Event Router - a highly available, central exchange point for events.
Event Router has what's known as an event bus and you can think of this like a constant flow of information and it routes information from producer to consumer.

Event-Driven Architecture-summary:

-No constant running or waiting for things.

-Producers generate events when something happens.

-Clicks, errors, criteria met, uploads, actions - all generate event.

-Events are delivered to consumers.

-After that actions are taken & the system returns to waiting.

-Mature event-driven architecture only consumes resources while handling events (serverless).

3 AWS LAMBDA - PART 1

Part 1 is a refresher of the topics covered at an associate level with some additional detail

Lambda is a FaaS (Function-as-a-Service) - short running and focused.

Lambda function - a piece of code lambda runs.

Functions use a runtime (example - Python 3.8)

Functions are loaded and run in a runtime environment.

The environment has a direct memory (indirect CPU) allocation.

You are billed for the duration that a function runs.

It is a key part of Serverless architectures.

Common uses of Lambda:

Serverless Applications (S3, API Gateway, Lambda)
File processing (S3, S3 Events, Lambda)
Database Triggers (DynamoDB, Streams, Lambda)
Serverless CRON (EventBridge/CWEvents + Lambda)
Realtime Stream Data Processing (Kinesis + Lambda)

4 AWS LAMBDA - PART 2

Part 2 of AWS Lambda looks at public & VPC networking, security and logging

Lambda has two networking modes: Public (which is default) and then we have VPC networking.

Lambda public networking - by default lambda functions are given public networking. They can access public AWS services and the public internet.
Public networking offers the best performance because no customer specific VPC networking is required.

For the private networking part - Lambda functions running in a VPC obey all VPC networking rules.
If we want VPC Lambdas to access internet resources we would have to deploy NatGW and Internet Gateway.
We also need to assign EC2 network permissions.

Security - Lambda execution roles are IAM roles attached to lambda functions which control the permissions the Lambda function receives.

Logging for AWS Lamnba:

Lambda uses CloudWatch, CloudWatch Logs & X-Ray
Logs from Lambda executions - CloudWatchLogs
Metrics - invocation success / failure, retries, latency stored in CloudWatch.
Lambda can be integrated with X-Ray for distributed tracing.
CloudWatch Logs requires permissions via Execution Role.

5 AWS LAMBDA - PART 3

Part 3 looks at invocation modes, versions & aliases, Latency, destinations and execution context

Invocation - three different methods:
Synchronous invocation
Asynchronous invocation
Event Source mappings

Lambda Versions:

Lambda functions have versions - v1, v2, v3 etc.
A version is the code + the configuration of the lambda function.
It's immutable - it never changes once published & has its own arn - Amazon Resource Name.
$Latest points at the latest version.
Aliases (DEV, STAGE, PROD) point at a version - can be changed.

6 CloudWatchEvents and EventBridge

CloudWatch Events and EventBridge have visibility over events generated by supported AWS services within an account.

They can monitor the default account event bus - and pattern match events flowing through and deliver these events to multiple targets.

They are also the source of scheduled events which can perform certain actions at certain times of day, days of the week, or multiple combinations of both - using the Unix CRON time expression format.

Both services are one way how event driven architectures can be implemented within AWS.

7 Automated EC2 Control using Lambda and Events - DEMO screens

I reproduced this scenario on my AWS account, find the screenshots below:

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/1ba6fcd2-9195-422e-aae0-8fa1ea16efec)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/c6f36ed8-c5b4-442a-bf46-b0514b279d17)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/048fc6d3-ecbe-4e8f-aa3f-07497da82921)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/ba0fceb2-4eea-4c80-ba6a-a8d727ce1763)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a3b5eff9-8b12-41b1-9876-48cc1682a1c1)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/375063a5-b39c-4557-8044-fa93d3fe0ca3)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/6c1ec036-1ad5-406f-9859-88e51848901f)








