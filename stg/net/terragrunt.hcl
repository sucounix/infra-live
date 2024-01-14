terraform {
  source = "git::https://github.com/sucounix/infra-modules.git//net?ref=net-v0.0.7"
  // source = "../../../infra-modules/net"
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

dependency "tf-core" {
  config_path = "../tf-core"
  skip_outputs = true
}