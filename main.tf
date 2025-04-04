# Configuração do provedor AWS
provider "aws" {
  region = "us-east-1" # Define a região onde os recursos serão criados

  # Define tags padrão para todos os recursos criados
  default_tags {
    tags = {
      Project = "AWS-Terraform"          # Nome do projeto
      Managed = "Terraform"              # Indica que a infraestrutura é gerenciada pelo Terraform
      Owner   = "Ricardo Simines Scopim" # Define o dono do recurso
      Env     = "Dev"                    # Define o ambiente de desenvolvimento
    }
  }
}

# Módulo VPC - Responsável por criar a VPC, sub-redes, Internet Gateway, NAT Gateway e tabelas de rotas
module "vpc" {
  source              = "./modules/vpc" # Diretório onde está o módulo VPC
  vpc_cidr            = "10.0.0.0/16"   # Define o bloco CIDR da VPC
  public_subnet_cidr  = "10.0.1.0/24"   # Define o bloco CIDR da sub-rede pública
  private_subnet_cidr = "10.0.2.0/24"   # Define o bloco CIDR da sub-rede privada
}

# Módulo de Segurança - Configura Security Groups e ACLs
module "security" {
  source             = "./modules/security" # Diretório do módulo de segurança
  vpc_id             = module.vpc.vpc_id    # Obtém o ID da VPC criada pelo módulo VPC
  public_subnet_cidr = "10.0.1.0/24"        # Bloco CIDR da sub-rede pública
}

# Módulo de Computação - Cria instâncias EC2 na sub-rede pública e privada
module "compute" {
  source         = "./modules/compute"                # Diretório do módulo de computação
  vpc_id         = module.vpc.vpc_id                  # Obtém o ID da VPC criada pelo módulo VPC
  public_subnet  = module.vpc.public_subnet           # Obtém a sub-rede pública criada
  private_subnet = module.vpc.private_subnet          # Obtém a sub-rede privada criada
  security_group = module.security.ec2_security_group # Associa o Security Group às instâncias EC2
}

# Módulo de Armazenamento - Cria um bucket S3 para armazenar backups e snapshots
module "storage" {
  source      = "./modules/storage"           # Diretório do módulo de armazenamento
  bucket_name = "meu-bucket-backup-terraform" # Nome do bucket S3
}

# Outputs principais para referência
output "public_ec2_ip" {
  value = module.compute.public_ec2_ip # Exibe o IP público da instância EC2 na sub-rede pública
}

output "private_ec2_id" {
  value = module.compute.private_ec2_id # Exibe o ID da instância EC2 na sub-rede privada
}

output "s3_bucket_name" {
  value = module.storage.s3_bucket_name # Exibe o nome do bucket S3 criado
}