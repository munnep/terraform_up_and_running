remote_state {
  backend = "s3"
  config = {

    bucket         = "terraform-up-and-running-state-patrick"

    key            = "${path_relative_to_include()}/terraform.tfstate"

    region         = "us-west-2"

    encrypt        = true

    dynamodb_table = "terraform-up-and-running-locks-patrick"

  }
}
