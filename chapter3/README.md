# chapter 3

## Terraform state to a S3 bucket

steps involved:
- create an S3 bucket and dynamoDB table
- add the remote backend configuration
```
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "terraform-up-and-running-state-patrick"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks-patrick"
    encrypt        = true
  }
}
```
- run ```terraform init``` and it will ask you to move the statefile to S3

## backend-config

file backend.hcl with
```
bucket = "terraform-up-and-running-state-patrick"
region = "us-west-2"
dynamodb_table = "terraform-up-and-running-locks-patrick"
encrypt        = true
```
edit the main.tf with only the key for the backend
```
terraform {
  backend "s3" {
    key    = "global/s3/terraform.tfstate"
  }
}
```

run terraform init 
```
terraform init -backend-config=backend.hcl
```

## workspaces

Use workspaces to isolate statefiles. 

You use the same terraform files but with different statefiles and therefore different environments. 

creating
```
terraform workspace new example1
```
selecting
```
terraform workspace select example1
```
which workspace you are
```
terraform workspace show
```
terraform workspace list
```
terraform workspace show
```
