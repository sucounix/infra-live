terraform {
  source = "git::https://github.com/sucounix/infra-modules.git//nodeg?ref=nodeg-v0.0.2"
  // source = "../../../infra-modules/nodeg"
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

dependency "cluster" {
  config_path = "../cluster"
  skip_outputs = true
}