variable "vpc_id" {
  description = "ID da VPC onde os Security Groups serão criados"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Bloco CIDR da sub-rede pública"
  type        = string
}
