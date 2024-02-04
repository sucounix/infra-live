terraform {
  // source = "git::https://github.com/sucounix/infra-modules.git//nodeg?ref=nodeg-v0.0.2"
  source = "../../../infra-modules/eks-addson"
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
  config_path = "../nodeg"
  skip_outputs = true
}

// generate "helm_provider" {
//   path      = "helm-provider.tf"
//   if_exists = "overwrite_terragrunt"
//   contents  = <<EOF

// provider "helm" {
//   kubernetes {
//     host                   = data.aws_eks_cluster.eks_cluster.endpoint
//     cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
//     token                  = data.aws_eks_cluster_auth.eks_cluster.token
//   }
// }
// EOF
// }