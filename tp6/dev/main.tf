terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
  required_version = "1.10.3"

  backend "s3" {
    region     = "us-east-1"
    shared_credentials_files = ["../../.secrets/credentials"]
    profile                  = "default"
  }
}


provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["../../.secrets/credentials"]
  profile                  = "default"
}

module "ec2" {
  source        = "../modules/ec2module"
  instance_type = "t2.nano"
  aws_common_tag = {
    Name = "ec2-dev-eazy-tp6"
  }
  sg_name = "eazy-dev-sg"
}