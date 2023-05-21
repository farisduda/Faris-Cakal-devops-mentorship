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

EC2 Instance Stop
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/0cb2e33f-d723-40da-a636-181c930e0628)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/375063a5-b39c-4557-8044-fa93d3fe0ca3)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/6c1ec036-1ad5-406f-9859-88e51848901f)

EC2 Instance Start

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/dd7af84d-44a0-41bb-8fc9-2f4236da8876)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/17c23777-41a1-435e-be32-e5bffc379cb8)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/99c6b18a-07a1-4b4e-98a1-3d6f6e62df88)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/6a723ea7-6120-48bc-993f-f343e447aac2)

EC2 Protect
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/482f5524-4f6d-4834-852b-d54b386d6220)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/67f78654-2d36-4054-98ec-cb8ca41697c4)

Creating Event Bridge rule to protect stopping instance 1
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/41331b7e-2f17-483f-8025-0516557acd07)

Stopping instance 2 which is not protected by Event Bridge rule:

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/c6c402a3-36c8-4dde-8489-28ed5936b2af)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/0abe5b18-7361-4ff0-b980-da5431604a3f)
It will remain in that state till we manually start it.

Stopping Instance 1 which we protect by Event Bridge rule and we will see what we will get as outcome.
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a8a135a8-a09d-4eee-aadc-063f81bf6b73)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/326a416f-7382-414f-8ed5-c9578b7a9a6d)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/87db916b-d509-4c42-99a0-1aac7d99ff80)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/150af3ff-9348-40fc-9dba-42f0a0528c9c)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/665c266b-287c-447d-b6df-9e22c095159f)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/30661980-d153-4515-aef2-ccf261cdaec2)

Cloud watch logs for Log Group EC2Protect where we can see all log events for that group.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/839e614f-ac81-424e-8639-e0b88fd01221)

Now we are going to manually start Instance 2 and create Event Bridge scheduled rule named EC2Stop:

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f64df2ad-3793-4518-b56d-6f33bff01936)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f31e378d-1ceb-4852-9d6f-b9b0a68d9c4b)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/1640afd9-195d-447b-bc7a-d73df8a25f80)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f7a0bd31-8b14-447b-8d53-65f007f02329)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/1960f697-f98f-4c4c-a0ad-e21cd62e8795)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/d1c611ab-8079-4f9a-9ad1-c6171f85eee8)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/fe00776f-cbcd-4d78-a808-def451e85fbd)

Here at the end we can see that this scheduled Event Bridge rule for stopping instances will trigger lambda fucntion to start stopping both instances. 
But with another event Bridge rule EC2Protect which we have previously created instance 1 is protected and it will return to state running.

8 Serverless Architecture

The Serverless architecture is a evolution/combination of other popular architectures such as event-driven and microservices.

It aims to use 3rd party services where possible and FAAS products for any on-demand computing needs.

Using a serverless architecture means little to no base costs for an environment - and any cost incurred during operations scale in a way with matches the incoming load.

9 Simple Notification Service

The Simple Notification Service or SNS .. is a Publishers/Subscribers style notification system which is used within AWS products and services but can also form an essential part of serverless, event-driven and traditional application architectures.
Publishers send messages to TOPICS
Subscribers receive messages SENT to TOPICS.

10 Step Functions
Step functions is a product which lets you build long running serverless workflow based applications within AWS which integrate with many AWS services such as Lambda function or using step funstions to create State Machines.

11 API Gateway 101

API Gateway is a managed service from AWS which allows the creation of API Endpoints, Resources & Methods.
The API gateway integrates with other AWS services - and can even access some without the need for dedicated compute.
It serves as a core component of many serverless architectures using Lambda as event-driven and on-demand backing for methods.

12 Pet-Cuddle-o-Tron PART1

The focus of the first part is SES (Simple Email Service) Configuration.

We need 2 different email addresses (where reminders will be sent from and received to).
First email verifed as identity:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f00c378a-dac1-4582-a347-fb7faf101bac)
Second email verified as identitiy:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a44a77db-59a5-4055-a038-6ac691b420a4)
Both identities:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/ef09134d-b947-4ade-9a54-d41ba08562ff)

13 Pet-Cuddle-o-Tron PART2

In this Advanced Demo you will be implementing a serverless reminder application.
The application will load from an S3 bucket and run in browser. 
Communicating with Lambda and Step functions via an API Gateway Endpoint.
Using the application you will be able to configure reminders for 'pet cuddles' to be sent using email.

Using stack linked with Cloud Formation template for creating IAM role which will be asumed by Lambda fucntion.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/6a5270a9-aa8b-4645-809b-64d8715b9d81)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f1d17119-d9c5-4165-9de7-3028d8d1ec6c)

Here it is:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/80091b91-d35c-45b7-8546-33d39fe4f3c4)

Now lets create Lambda fucntion email reminder.
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/ada4a1b7-4152-4959-b419-82368b436ee0)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/042fa934-69c5-4f23-bbed-2b243f3eff17)

14 Pet-Cuddle-o-Tron PART3

In this part we will be adding State Machine that will be configured to use SES via the Lambda function created earlier.

Creating role for the State Machine by using CloudFormation stack:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/3d97b68b-9b16-444c-b254-a92a7aef085e)
Created State machine :
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/e04fb436-021f-42d6-9a5a-5cf4ad7b759e)

Creating lambda function which will support the API Gateway:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/747b2e20-72b8-4676-945b-074f0aba6ae1)
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/8cb6080c-14d9-4093-af2a-99692a67d171)

Creating REST API with resources:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/8b015364-da7e-4e25-9712-81723d8d51bd)
Creating a Method and a POST Method in this API Gateway:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a96a565f-1614-4ad8-98ae-3696e405afc1)

After deploying our API in the next screen at the top of the screen will be an Invoke URL .. note this down somewhere safe, you will need it in the next STAGE.
This URL will be used by the client side component of the serverless application and this will be unique to as.
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/de1b6665-492c-4e03-8f25-eda89c16eefd)

16 Pet-Cuddle-o-Tron Part5

Create S3 bucket:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/1a4ad5c1-71ea-419f-bdc7-0e4387addc70)

Editing bucket policy:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/d1fbbcf0-c9cb-48f9-afde-665b56bc8656)
Enabling ststic web hosting on thi sbucket:
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/5ea3e9ba-18b6-4f0a-8e1d-1fe2eea701c5)
Adding files to the S3 bucket:





































