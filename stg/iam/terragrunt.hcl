terraform {
  // source = "git::https://github.com/sucounix/infra-modules.git//iam?ref=iam-v0.0.4"
  source = "../../../infra-modules/iam"
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

dependency "net" {
  config_path = "../net"
  skip_outputs = true
}