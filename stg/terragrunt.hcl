locals {
  environment = "stg"
  aws_region = "eu-west-1"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend-tf-core.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    // role_arn       = "arn:aws:iam::344845126663:role/terraform"
    bucket         = "stg-tf-state-workshop-e0ee3bb6c57e93dc"
    key            = "${path_relative_to_include()}/terraform_locks_tf-core.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "stg_terraform_locks_tf-core"
  }
}

# Dont un commet
  // backend "s3" {
  //   bucket         = "dev-tf-state-workshop-10ec87d81e6a483f"
  //   key            = "terraform/terraform_locks_tf-core.tfstate"
  //   region         = "eu-west-1"
  //   dynamodb_table = "terraform_locks_tf-core"
  //   encrypt        = "true"
  // }




// remote_state {
//   backend = "local"
//   generate = {
//     path      = "backend-tf-core.tf"
//     if_exists = "overwrite_terragrunt"
//   }

//   config = {
//     path = "${path_relative_to_include()}/terraform.tfstate"
//   }
// }

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

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
    region = "${local.aws_region}"
}
EOF
}


// generate "vars-main" {
//   path      = "vars-main.tf"
//   if_exists = "overwrite_terragrunt"

//   contents = <<EOF
// # TF_VAR_region
// variable "region" {
//   description = "The name of the AWS Region"
//   type        = string
//   default     = "eu-west-1"
// }

// variable "profile" {
//   description = "The name of the AWS profile in the credentials file"
//   type        = string
//   default     = "default"
// }

// variable "environment" {
//   type        = string
//   description = "(optional) describe your variable"
//   default     = "dev"
// }

// variable "cluster-name" {
//   description = "The name of the EKS Cluster"
//   type        = string
//   default     = "mycluster1"
// }


// variable "eks_version" {
//   type    = string
//   default = "1.28"
// }

// variable "no-output" {
//   description = "The name of the EKS Cluster"
//   type        = string
//   default     = "secret"
//   sensitive   = true
// }
// EOF
// }