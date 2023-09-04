# Terraform
Terrafrom learning journey Code 

I've created some demo infrastructure using aws provider, my directory structure looked like:

0_remote_state: contains the code responsible for creating the s3 bucket to store terraform state (terraform statefile is a file contains all data about provisioned infrastructure)

1_infrastructure: contains the VPC settings (Public subnets, private subnets, Also locals variables to be called on terraform_remote_state data source and to align for example common tags name )

2_databases: contains RDS database code

3_s3Buckets: create S3 buckets to store artifacts, logs, data

4_loadbalancers: create ALBs which being used by applications

5_services: a custom module i've created implementing reusable infrastructure concepts which manages (alb_rules, ASGs, IAM, launch_templates, security groups, target groups)

applications: contains terraform applications code that uses the 5_services module

Now when creating new application, you just edit the vars.tf and create a module on for example (superapp.tf) defining all things you need when you create regular ec2 instance.
