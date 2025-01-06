
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
  key_name        = var.key_name
  tags            = var.aws_common_tag
  security_groups = var.security_groups
  availability_zone = var.AZ
}
