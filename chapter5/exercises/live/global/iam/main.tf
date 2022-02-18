provider "aws" {
  region  = "us-west-2"
  version = "<4.0.0"
}


resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.key
}