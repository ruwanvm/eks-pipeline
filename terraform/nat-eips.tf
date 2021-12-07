resource "aws_eip" "nat-eip-1" {
  depends_on = [aws_internet_gateway.eks-igw]
  vpc        = true
  tags = {
    Name    = "${var.environment}-eks-nat-eip-1"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}

resource "aws_eip" "nat-eip-2" {
  depends_on = [aws_internet_gateway.eks-igw]
  vpc        = true
  tags = {
    Name    = "${var.environment}-eks-nat-eip-2"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}