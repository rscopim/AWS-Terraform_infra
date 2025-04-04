variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Bloco CIDR da sub-rede pública"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Bloco CIDR da sub-rede privada"
  type        = string
}
