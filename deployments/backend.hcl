remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    key            = "${path_relative_to_include()}/terraform.tfstate"
    bucket         = "terraform-up-and-running-state-593493008121"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}