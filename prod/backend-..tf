# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "prod-tf-state-workshop-1e340d14a423e040"
    dynamodb_table = "prod_terraform_locks_."
    encrypt        = true
    key            = "./terraform_locks_..tfstate"
    region         = "eu-west-1"
  }
}
