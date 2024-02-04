# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
data "aws_ssm_parameter" "tf-eks-id" {
  name = "/prod/tf-eks/id"
}

data "aws_ssm_parameter" "tf-eks-keyid" {
  name = "/prod/tf-eks/keyid"
}

data "aws_ssm_parameter" "tf-eks-keyarn" {
  name = "/prod/tf-eks/keyarn"
}

data "aws_ssm_parameter" "tf-eks-region" {
  name = "/prod/tf-eks/region"
}

data "aws_ssm_parameter" "tf-eks-cluster-name" {
  name = "/prod/tf-eks/cluster-name"
}

data "aws_ssm_parameter" "tf-eks-version" {
  name = "/prod/tf-eks/eks-version"
}

data "aws_ssm_parameter" "environment" {
  name = "/prod/environment"
}
