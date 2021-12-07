resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
    Name    = "${var.environment}-eks-internet-gateway"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}
