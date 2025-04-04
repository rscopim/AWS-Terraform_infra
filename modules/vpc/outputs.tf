# Outputs para exportar informações importantes da VPC

# Output do ID da VPC criada
output "vpc_id" {
  description = "ID da VPC criada" # Descrição do output
  value       = aws_vpc.main.id    # Retorna o ID da VPC criada
}

# Output do ID da sub-rede pública
output "public_subnet" {
  description = "ID da sub-rede pública" # Descrição do output
  value       = aws_subnet.public.id     # Retorna o ID da sub-rede pública
}

# Output do ID da sub-rede privada
output "private_subnet" {
  description = "ID da sub-rede privada" # Descrição do output
  value       = aws_subnet.private.id    # Retorna o ID da sub-rede privada
}
