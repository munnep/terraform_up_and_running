# Chapter 6

Create modules as small as possible so you can easily link one to another

The bigger the module
- more difficult to debug
- more difficult to test
- more difficult to review
- mistakes are easier to make

## composable modules

Point from one module to another module

## version pinning

terraform
```
terraform {
# Require any 0.12.x version of Terraform 
required_version = ">= 0.12, < 0.13"
}
```
provider
```
provider "aws" { 
    region = "us-east-2"
      # Allow any 2.x version of the AWS provider
      version = "~> 2.0"
    }
```

## releasable modules

Tag your module within git and reference that when using the module.
example
```
module "hello_world_app" {

  source = "git@github.com:foo/modules.git//services/hello-world-app?ref=v0.0.5"
  server_text            = "New server text"
```  

Terraform private module does it a bit different
https://learn.hashicorp.com/tutorials/terraform/module-private-registry-share?in=terraform/modules


