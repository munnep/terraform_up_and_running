provider "aws" {
  region  = "us-west-2"
  version = "~> 3.0"
}

terraform {
  backend "s3" {
    key            = "workspaces-example/terraform.tfstate"
    bucket         = "terraform-up-and-running-state-patrick"
    region         = "us-west-2"
    dynamodb_table = "terraform-up-and-running-locks-patrick"
    encrypt        = true
  }
}
resource "aws_instance" "example" {
  ami           = "ami-074251216af698218"
  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}