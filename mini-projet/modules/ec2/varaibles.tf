variable "instance_type" {
  type        = string
  description = "set aws instance type"
  default     = "t2.nano"
}

variable "aws_common_tag" {
  type        = map(any)
  description = "set aws tag"
  default = {
    Name = "ec2-eazytraining-mini-projet"
  }
}

variable "security_groups" {
  type    = set(string)
  default = null
}

variable "key_name" {
  description = "Nom de la paire de clés à créer dans AWS"
  type        = string
}
