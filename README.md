# Repository for the EKS Infrastructure in AWS

## Features

* `./cloudformation-infra/` Files to deploy the VPC.
* `./terraform-eks/` Files to deploy an EKS cluster over the above VPC.


## Architecture

![](./ARQ-EmiratesCaseStudy.jpg)

## How to use

1. Deploy VPC:

* Copy the yaml files from `./cloudformation-infra/` into a S3 Bucket (Ex. MyBucket).
* In the AWS console, go to Cloudformation service and create a new stack using the URL for the master
file (ex, https://MyBucket.s3.amazonaws.com/master.yaml).
* In the next Specify stack details window add:
    * One of the following names for the Stack Name field:
        * OPS
        * DEV
        * QA
        * PROD
        
    * In the SourceCode verify the name of the Bucket (Ex. MyBucket) where the yaml files were saved.
    
2. Deploy EKS:
* In the file `./terraform-eks/main.tf` add the VPC ID and the private subnets IDs created in the previous step:

```
  subnets         = ["subnet-0c27636ae347e01e7", "subnet-032f530b700ba3a7d", "subnet-040a5a687412aa3f8"] 
  vpc_id          = "vpc-014be38c2058c2123"
```
* Set the AWS credentials:

````
aws config
````

* Deploy the EKS cluster:


````
terraform init
terraform plan
terraform apply
````