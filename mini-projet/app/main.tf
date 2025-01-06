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
  key_name        = local.key_pair_key_name
  security_groups = [module.sg.aws_security_group_name]
  AZ              = local.AZ
}

module "eip" {
  source = "../modules/eip"
}

module "ebs" {
  source = "../modules/ebs"
  AZ     = local.AZ
  size   = local.size
}

module "key_pair" {
  source          = "../modules/key_pair"
  key_name        = local.key_pair_key_name
  private_key_path = "../.ssh/dynamic_key.pem" # Chemin pour stocker la clé privée
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

resource "null_resource" "ip_resource" {
  depends_on = [module.eip]
  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${module.eip.aws_eip_ip} DNS: ${module.eip.aws_eip_domaine_name} > jenkins_ec2.txt"
  }
}

resource "null_resource" "install_jenkins_resource" {
  depends_on = [module.key_pair, module.eip]

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install -y openjdk-17-jdk",
      "wget -q -O jenkins.deb https://pkg.jenkins.io/debian-stable/binary/jenkins_2.414.1_all.deb",
      "sudo dpkg -i jenkins.deb",
      "sudo apt-get -f install"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(module.key_pair.private_key_path)
      host        = module.eip.aws_eip_ip
    }
  }
}