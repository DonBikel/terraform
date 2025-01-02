resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096 # Taille de la clé pour plus de sécurité
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

# Sauvegarder la clé privée localement, pour connexion SSH aux instances EC2
resource "local_file" "private_key" {
  filename = var.private_key_path
  content  = tls_private_key.this.private_key_pem
  file_permission = "0600"
}