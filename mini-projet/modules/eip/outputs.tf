output "aws_eip_ip" {
  value = aws_eip.eip.public_ip
}

output "aws_eip_id" {
  value = aws_eip.eip.id
}

output "aws_eip_domaine_name" {
  value = aws_eip.eip.domain
}