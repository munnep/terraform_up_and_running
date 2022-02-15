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

## different directories

make different directories to store your environments. 

To still get other data use the remote_state option
```
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "terraform-up-and-running-state-patrick"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-west-2"
  }
}
```
this way you have the option to read data like following
```
data.terraform_remote_state.db.outputs.port
```

##  template_file

instead of this in the instance
```
user_data = <<EOF
#!/bin/bash
echo "Hello, World" >> index.html
echo "${data.terraform_remote_state.db.outputs.address}" >> index.html echo "${data.terraform_remote_state.db.outputs.port}" >> index.html nohup busybox httpd -f -p ${var.server_port} &
EOF
```

you could create a file called user-data
```
#!/bin/bash
cat > index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

nohup busybox httpd -f -p ${server_port} &
```
and in your code use these values
```
data "template_file" "user_data" {
  template = file("user-data.sh")
  vars = {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  }
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-074251216af698218"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]
  user_data       = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}
```
