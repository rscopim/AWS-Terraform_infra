variable "vpc_id" {
  description = "ID da VPC onde as instâncias serão criadas"
  type        = string
}

variable "public_subnet" {
  description = "ID da sub-rede pública"
  type        = string
}

variable "private_subnet" {
  description = "ID da sub-rede privada"
  type        = string
}

variable "security_group" {
  description = "ID do Security Group para as instâncias EC2"
  type        = string
}
