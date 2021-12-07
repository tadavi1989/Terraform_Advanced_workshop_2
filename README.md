# Workshop-environment
This repo creates "environment" modules with all the necessary resources to enable end-to-end interaction with a Web-app and RDS (still working on it...)

## Provisioning the next:
- Load-Balancer
- LaunchConfiguration including a user-data script
- AutoscalingGroup
- RDS
- Security groups

## Persistence
- The terraform statefile is stored in an AWS S3 bucket
- The terraform lock file is stored in AWS Dynamodb

I want to create a web-application(apache2 server) cluster on EC2 instances. 
to autoscale the cluster with an Autoscaling group, with 2 intances minimum at a time.
to put the instances behind a load balancer (with ELB/ALB)
to keep the state in s3 and manage Lock in DynamoDB

### RDS
create an RDS database
