Architecture deep dive part 1 - Simple using ALB to scale the processing part in tiered architecture example. It is better solution then Monolith infrastructure where storage, load and processing depends on each other. In tiered architectire example we have HA for processing part. If one of the instances fails laod balancer move s processing to another instances which is healthy.


