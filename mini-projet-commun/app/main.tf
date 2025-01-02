terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
  required_version = "1.10.3"
}

provider "aws" {
  region                   = local.region
  shared_credentials_files = ["../../.secrets/credentials"]
  profile                  = "default"
}

module "sg" {
  source = "../modules/sg"
}

module "ec2" {
  source          = "../modules/ec2"
  instance_type   = local.instance_type
  aws_common_tag  = local.aws_common_tag
  security_groups = [module.sg.aws_security_group_name]
}

module "eip" {
  source = "../modules/eip"
}

module "ebs" {
  source = "../modules/ebs"
  AZ     = local.AZ
  size   = local.size
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.aws_ebs_volume_id
  instance_id = module.ec2.aws_instance_id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.aws_instance_id
  allocation_id = module.eip.aws_eip_id
}

resource "null_resource" "name" {
  depends_on = [module.eip]
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${module.eip.aws_eip_id} > ip_ec2.txt"
  }
}