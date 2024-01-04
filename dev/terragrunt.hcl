// locals {
//   environment = "dev"
//   aws_region = "eu-west-1"
// }
// // remote_state {
// //   backend = "s3"
// //   generate = {
// //     path      = "state.tf"
// //     if_exists = "overwrite_terragrunt"
// //   }

// //   config = {
// //     role_arn       = "arn:aws:iam::344845126663:role/terraform"
// //     bucket         = "femtotra-terraform-state"
// //     key            = "${local.environment}/${path_relative_to_include()}/terraform.tfstate"
// //     region         = "${local.aws_region}"
// //     encrypt        = true
// //     dynamodb_table = "terraform-lock-table"
// //   }
// // }

locals {
  env = "dev"
}

remote_state {
  backend = "local"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "aws" {
  path      = "aws.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  # specify minimum version of Terraform 
  required_version = "> 1.4.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #  Lock version to prevent unexpected problems
      version = "5.31.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.24.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.1"
    }

  }
}
EOF
}