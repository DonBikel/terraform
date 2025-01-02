variable "key_name" {
  description = "Nom de la paire de clés à créer dans AWS"
  type        = string
}

variable "private_key_path" {
  description = "Chemin du fichier où stocker la clé privée localement"
  type        = string
  default     = "../.ssh/generated_key.pem"
}