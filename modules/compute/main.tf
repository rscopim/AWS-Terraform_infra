# Criar uma chave SSH para acesso às EC2
resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub") # Substitua pelo caminho da sua chave pública
}

# Criar instância EC2 na sub-rede pública
resource "aws_instance" "public_ec2" {
  ami                    = "ami-00a929b66ed6e0de6" # Substitua pelo AMI mais recente da sua região
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet
  vpc_security_group_ids = [var.security_group]
  key_name               = aws_key_pair.ssh_key.key_name


  # Script de inicialização da instância pública
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              echo "<h1>Servidor EC2 Pública</h1>" | sudo tee /var/www/html/index.html
              sudo systemctl enable apache2
              sudo systemctl start apache2
              EOF

  tags = {
    Name = "Public-EC2"
  }
}

# Criar instância EC2 na sub-rede privada
resource "aws_instance" "private_ec2" {
  ami                    = "ami-00a929b66ed6e0de6" # Substitua pelo AMI mais recente da sua região
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet
  vpc_security_group_ids = [var.security_group]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Private-EC2"
  }
}
