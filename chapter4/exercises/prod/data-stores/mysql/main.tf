provider "aws" {
  region  = "us-west-2"
  version = "<4.0.0"
}

terraform {
  backend "s3" {
    key            = "prod/data-stores/mysql/terraform.tfstate"
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

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 3
  desired_capacity      = 3
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              = 2
  max_size              = 2
  desired_capacity      = 2
  recurrence            = "0 10 * * *"

  autoscaling_group_name = module.webserver_cluster.asg_name
}