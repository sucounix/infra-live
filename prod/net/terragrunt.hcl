terraform {
  source = "git::https://github.com/sucounix/infra-modules.git//net?ref=net-v0.0.8"
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
  vpc-cidr-cluster        = "10.2.0.0/16"
  vpc-cidr-assoc          = "100.64.0.0/16"
  subnet-i1               = "100.64.0.0/18"
  subnet-i2               = "100.64.64.0/18"
  subnet-i3               = "100.64.128.0/18"
  subnet-pub1             = "10.2.0.0/21"
  subnet-pub2             = "10.2.8.0/21"
  subnet-pub3             = "10.2.16.0/21"
  subnet-priv1            = "10.2.24.0/21"
  subnet-priv2            = "10.2.32.0/21"
  subnet-priv3            = "10.2.40.0/21"
}

dependency "tf-core" {
  config_path = "../tf-core"
  skip_outputs = true
}