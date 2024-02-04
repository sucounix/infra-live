terraform {
  // source = "git::https://github.com/sucounix/infra-modules.git//rds?ref=rds-v0.0.5"
  source = "../../../infra-modules/04-rds"
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
  environment               = include.env.locals.environment
  region                    = include.env.locals.aws_region
  db-identifier             = "devdb"
}

dependency "net" {
  config_path = "../02-net"
  skip_outputs = true
}