output "key_name" {
  description = "Nom de la paire de clés enregistrée dans AWS"
  value       = aws_key_pair.this.key_name
  sensitive   = true
}

output "private_key_path" {
  description = "Chemin du fichier de la clé privée localement stockée"
  value       = var.private_key_path
  sensitive   = true
}
