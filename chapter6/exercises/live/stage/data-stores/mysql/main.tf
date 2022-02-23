provider "aws" {
  region  = "us-west-2"
  version = "<4.0.0"
}

terraform {
  backend "s3" {
    key            = "stage/data-stores/mysql/terraform.tfstate"
    bucket         = "terraform-up-and-running-state-patrick"
    region         = "us-west-2"
    dynamodb_table = "terraform-up-and-running-locks-patrick"
    encrypt        = true
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  skip_final_snapshot = true
  password            = var.db_password
  apply_immediately = true
}