terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
    backend "s3" {
      bucket = "terraformstatebucketca2023"
      key    = "tutorial/prod/us-west-1/network.tfstate"
      dynamodb_table="terraformstatebucketca2023"
      region = "us-east-1"
  }
}

module "network" {
  source              = "../../../modules/network"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  region_location     = var.region_location
}