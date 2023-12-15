terraform {
  source = "git::https://github.com/sucounix/infra-modules.git//vpc?ref=vpc-v0.0.1"
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
  env             = include.env.locals.env
  azs             = ["us-east-1a", "us-east-1b"]
  vpc_cidr_block  = "10.3.0.0/16"
  private_subnets = ["10.3.0.0/19", "10.3.32.0/19"]
  public_subnets  = ["10.3.64.0/19", "10.3.96.0/19"]

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/dev-demo"  = "owned"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"         = 1
    "kubernetes.io/cluster/dev-demo" = "owned"
  }
}
