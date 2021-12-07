# Workshop-environment
This repo creates "environment" modules with all the necessary resources to enable end-to-end interaction with a Web-app and RDS

## What are we provisioning here?
- Load-Balancer
- LaunchConfiguration including a user-data script
- AutoscalingGroup
- RDS
- Security groups

## Persistence
- The terraform statefile is stored in an AWS S3 bucket
- The terraform lock file is stored in AWS Dynamodb

## Assignments

Fork and clone / copy the content of this repository, and complete the tasks below (work closely with the terraform documentation):

### Moduls
Complete all the missing pieces in the /modules/main.tf file

### WORKSHOP APP
Complete all the nessacery resources to achieve the followings:
We want to create a web-application(apache2 server) cluster on EC2 instances. 
We like to autoscale the cluster with an Autoscaling group, with 2 intances minimum at a time.
We want to put the instances behind a load balancer (start with ELB, after everything works, you may try ALB)
We don't want unhealthy instances to get traffic
We want to keep the state in s3 and manage Lock in DynamoDB

Requirements: 
- Use free-tier instances only (t2.micro)
- All resources must be a part of the VPC you created earlier
- All resources will use public subnets, to allow traffic from outside
- The instances should allow incoming traffic on port 80 from the LB only
- The instances should allow SSH access to the admin user
- Incoming traffic for each resource must restrict the port-range to the minimum

### Global-RDS
Complete all the necessary resources to achieve the followings:
We want to create an RDS database

Requirements: 
- Use free-tier instances only (t2.micro)
- All resources must be a part of the VPC you created earlier
- All resources will use private subnets, to allow traffic only from the instances...
- Incoming traffic for each resource must restrict the port-range to the minimum

### Bonus
- Separate the resources of modules and resources