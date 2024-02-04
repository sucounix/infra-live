terraform {
  // source = "git::https://github.com/sucounix/infra-modules.git//cluster?ref=cluster-v0.0.2"
  source = "../../../infra-modules/10-cluster"
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
}

dependency "iam" {
  config_path = "../05-iam"
  skip_outputs = true
}