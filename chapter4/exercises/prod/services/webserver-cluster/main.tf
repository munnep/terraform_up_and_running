provider "aws" {
  region  = "us-west-2"
  version = "<4.0.0"
}

terraform {
  backend "s3" {
    key            = "prod/services/webserver-cluster/terraform.tfstate"
    bucket         = "terraform-up-and-running-state-patrick"
    region         = "us-west-2"
    dynamodb_table = "terraform-up-and-running-locks-patrick"
    encrypt        = true
  }
}


module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-up-and-running-state-patrick"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}


