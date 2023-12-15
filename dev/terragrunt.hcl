remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    role_arn       = "arn:aws:iam::344845126663:role/terraform"
    bucket         = "femtotra-terraform-state"
    key            = "get_env("env")/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
    region = "us-east-1"
}
EOF
}
