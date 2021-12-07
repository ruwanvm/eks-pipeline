resource "aws_nat_gateway" "nat-gw-1" {
  allocation_id = aws_eip.nat-eip-1.id
  subnet_id     = aws_subnet.eks-public-subnet-1.id
  tags = {
    Name    = "${var.environment}-EKS-NAT-GW-1"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}

resource "aws_nat_gateway" "nat-gw-2" {
  allocation_id = aws_eip.nat-eip-2.id
  subnet_id     = aws_subnet.eks-public-subnet-2.id
  tags = {
    Name    = "${var.environment}-EKS-NAT-GW-2"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}