
data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["*ubuntu-bionic*"]
  }
}


module "key_pair" {
  source          = "../key_pair"
  key_name        = "my-dynamic-key"  
  private_key_path = "../.ssh/dynamic_key.pem" # Chemin pour stocker la clé privée
}


resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instance_type
  key_name        = module.key_pair.key_name
  tags            = var.aws_common_tag
  security_groups = var.security_groups

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
      host        = self.public_ip
    }
  }
}