locals {
  environment = "stg"
  aws_region = "eu-west-1"
}

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


remote_state {
  backend = "s3"
  generate = {
    path      = "backend-${path_relative_to_include()}.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    // role_arn       = "arn:aws:iam::344845126663:role/terraform"
    bucket         = "dev-tf-state-workshop-232c6cb36b7bf900"
    key            = "${path_relative_to_include()}/terraform_locks_${path_relative_to_include()}.tfstate"
    region         = "${local.aws_region}"
    encrypt        = true
    dynamodb_table = "dev_terraform_locks_${path_relative_to_include()}"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
    region = "${local.aws_region}"
}
provider "null" {}
provider "external" {}
EOF
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

generate "ssm_parameter" {
  path      = "data-params-setup.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
data "aws_ssm_parameter" "tf-eks-id" {
  name = "/${local.environment}/tf-eks/id"
}

data "aws_ssm_parameter" "tf-eks-keyid" {
  name = "/${local.environment}/tf-eks/keyid"
}

data "aws_ssm_parameter" "tf-eks-keyarn" {
  name = "/${local.environment}/tf-eks/keyarn"
}

data "aws_ssm_parameter" "tf-eks-region" {
  name = "/${local.environment}/tf-eks/region"
}

data "aws_ssm_parameter" "tf-eks-cluster-name" {
  name = "/${local.environment}/tf-eks/cluster-name"
}

data "aws_ssm_parameter" "tf-eks-version" {
  name = "/${local.environment}/tf-eks/eks-version"
}

data "aws_ssm_parameter" "environment" {
  name = "/${local.environment}/environment"
}

EOF
}

generate "aws_data" {
  path      = "aws-data.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "az" {
  state = "available"
}
EOF
}