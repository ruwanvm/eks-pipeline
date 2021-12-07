resource "tls_private_key" "rsa-key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "ec2-key" {
  key_name   = "kubectl-master-key"
  public_key = tls_private_key.rsa-key.public_key_openssh
  tags       = var.aws_tags
}

resource "local_file" "private-key-file" {
  content         = tls_private_key.rsa-key.private_key_pem
  filename        = "../tmp/${var.environment}-key.pem"
  file_permission = "0600"
}