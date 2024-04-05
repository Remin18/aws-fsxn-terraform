terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.42.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "fsxn" {
  source = "./modules/fsxn"

  project_prefix     = var.project_prefix
  region             = var.region
  vpc_id             = var.vpc_id
  vpc_cidr_block     = var.vpc_cidr_block
  subnet_id          = var.subnet_id
  fsx_admin_password = var.fsx_admin_password
}
