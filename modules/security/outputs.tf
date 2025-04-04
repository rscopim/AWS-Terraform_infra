output "ec2_security_group" {
  description = "ID do Security Group associado às instâncias EC2"
  value       = aws_security_group.public_sg.id
}
