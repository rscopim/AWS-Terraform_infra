# Security Group para EC2 Pública (Acesso via HTTP e SSH)
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = var.vpc_id

  # Permite acesso HTTP (porta 80) de qualquer lugar
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite acesso SSH (porta 22) apenas do seu IP (modifique conforme necessário)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regras de saída (permitindo todo tráfego)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-public-sg"
  }
}

# Security Group para EC2 Privada (Permite apenas tráfego interno)
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow only internal traffic"
  vpc_id      = var.vpc_id

  # Permite acesso na porta 22 (SSH) apenas da sub-rede pública
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  # Permite acesso HTTP apenas da sub-rede pública
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr]
  }

  # Regras de saída (permitindo todo tráfego)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-private-sg"
  }
}

# Network ACLs para a VPC (opcional)
resource "aws_network_acl" "main_acl" {
  vpc_id = var.vpc_id

  # Permitir todo tráfego de entrada e saída (padrão)
  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "terraform-main-acl"
  }
}

