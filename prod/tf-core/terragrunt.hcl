terraform {
  source = "git::https://github.com/sucounix/infra-modules.git//tf-core?ref=tf-core-v0.0.9"
  // source = "../../../infra-modules/tf-core"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("terragrunt.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  environment             = include.env.locals.environment
  region                  = include.env.locals.aws_region
  cluster-name            = "stg-k8s-cluster"
  // azs             = ["us-east-1a", "us-east-1b"]
  // vpc_cidr_block  = "10.1.0.0/16"
  // private_subnets = ["10.1.0.0/19", "10.1.32.0/19"]
  // public_subnets  = ["10.1.64.0/19", "10.1.96.0/19"]

  // private_subnet_tags = {
  //   "kubernetes.io/role/internal-elb" = 1
  //   "kubernetes.io/cluster/dev-demo"  = "owned"
  // }

  // public_subnet_tags = {
  //   "kubernetes.io/role/elb"         = 1
  //   "kubernetes.io/cluster/dev-demo" = "owned"
  // }
}

