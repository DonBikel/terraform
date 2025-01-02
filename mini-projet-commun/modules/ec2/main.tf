
data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["*ubuntu-bionic*"]
  }
}


resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instance_type
  key_name        = "mini-projet-gitlab"
  tags            = var.aws_common_tag
  security_groups = var.security_groups


  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../../.secrets/mini-projet-gitlab.pem")
      host        = self.public_ip
    }
  }

  root_block_device {
    delete_on_termination = true
  }
}