# Criar o bucket S3 para armazenamento de backups e snapshots
resource "aws_s3_bucket" "backup_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Terraform"
  }
}

# Definir controle de propriedade do bucket para evitar problemas de ACL
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.backup_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Política para evitar acessos públicos acidentais
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.backup_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

