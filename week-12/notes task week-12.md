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
