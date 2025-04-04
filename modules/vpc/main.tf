# Módulo VPC
# Criação da VPC, sub-redes, Internet Gateway, NAT Gateway e tabelas de rotas

# Criação da VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # Define o bloco CIDR da VPC
  enable_dns_support   = true          # Habilita suporte a DNS na VPC
  enable_dns_hostnames = true          # Permite que instâncias recebam hostnames DNS

  tags = {
    Name = "MinhaVPC" # Nome da VPC
  }
}

# Criação da sub-rede pública
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id # Associa a sub-rede à VPC criada
  cidr_block              = "10.0.1.0/24"   # Define o bloco CIDR da sub-rede pública
  map_public_ip_on_launch = true            # Permite que instâncias recebam IPs públicos automaticamente

  tags = {
    Name = "PublicSubnet" # Nome da sub-rede pública
  }
}

# Criação da sub-rede privada
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id # Associa a sub-rede à VPC criada
  cidr_block = "10.0.2.0/24"   # Define o bloco CIDR da sub-rede privada

  tags = {
    Name = "PrivateSubnet" # Nome da sub-rede privada
  }
}

# Criação do Internet Gateway para permitir acesso à internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id # Associa o Internet Gateway à VPC

  tags = {
    Name = "InternetGateway" # Nome do Internet Gateway
  }
}

# Criação da tabela de rotas para a sub-rede pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id # Associa a tabela de rotas à VPC

  route {
    cidr_block = "0.0.0.0/0"                # Define que todo o tráfego externo deve sair pela internet
    gateway_id = aws_internet_gateway.gw.id # Associa o Internet Gateway à rota
  }

  tags = {
    Name = "PublicRouteTable" # Nome da tabela de rotas pública
  }
}

# Associação da tabela de rotas pública à sub-rede pública
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id      # Associa à sub-rede pública
  route_table_id = aws_route_table.public.id # Associa à tabela de rotas pública
}

# Criação do Elastic IP necessário para o NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc" # Indica que este EIP será usado dentro da VPC
}

# Criação do NAT Gateway para permitir que a sub-rede privada acesse a internet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id       # Usa o Elastic IP criado anteriormente
  subnet_id     = aws_subnet.public.id # O NAT Gateway deve estar na sub-rede pública

  tags = {
    Name = "NATGateway" # Nome do NAT Gateway
  }
}

# Criação da tabela de rotas para a sub-rede privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id # Associa a tabela de rotas à VPC

  route {
    cidr_block     = "0.0.0.0/0"            # Define que todo o tráfego externo deve passar pelo NAT Gateway
    nat_gateway_id = aws_nat_gateway.nat.id # Associa o NAT Gateway à rota
  }

  tags = {
    Name = "PrivateRouteTable" # Nome da tabela de rotas privada
  }
}

# Associação da tabela de rotas privada à sub-rede privada
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id      # Associa à sub-rede privada
  route_table_id = aws_route_table.private.id # Associa à tabela de rotas privada
}
