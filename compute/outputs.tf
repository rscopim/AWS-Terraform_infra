output "public_ec2_ip" {
  description = "Endereço IP público da instância EC2 na sub-rede pública"
  value       = aws_instance.public_ec2.public_ip
}

output "private_ec2_id" {
  description = "ID da instância EC2 na sub-rede privada"
  value       = aws_instance.private_ec2.id
}
