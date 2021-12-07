locals {
  kubectl_ssh_user = "ubuntu"
}

data "aws_ami" "kubectl_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "http" "workstation-ip" {
  url = "https://api.ipify.org"
}

resource "aws_security_group" "kubectl-sg" {
  name   = "${var.environment}-kubectl-sg"
  vpc_id = aws_vpc.eks-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.environment}-kubectl-sg"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}

resource "aws_instance" "kubectl-server" {
  ami                         = data.aws_ami.kubectl_ami.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.kubectl-sg.id]
  subnet_id                   = aws_subnet.eks-public-subnet-1.id

  tags = {
    Name    = "${var.environment}-kubectl-server"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
  key_name = aws_key_pair.ec2-key.id

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.kubectl_ssh_user
      private_key = tls_private_key.rsa-key.private_key_pem
      host        = aws_instance.kubectl-server.public_ip
    }
  }

  depends_on = [
    aws_key_pair.ec2-key,
    local_file.private-key-file,
  ]
}
