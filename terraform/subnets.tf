resource "aws_subnet" "eks-public-subnet-1" {
  cidr_block              = "10.29.10.0/24"
  vpc_id                  = aws_vpc.eks-vpc.id
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name                                                   = "${var.environment}-eks-public-subnet-1"
    "kubernetes.io/cluster/${var.environment}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                               = 1
    Purpose                                                = var.aws_tags["Purpose"]
    Owner                                                  = var.aws_tags["Owner"]
  }
}

resource "aws_subnet" "eks-public-subnet-2" {
  cidr_block              = "10.29.11.0/24"
  vpc_id                  = aws_vpc.eks-vpc.id
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name                                                   = "${var.environment}-eks-public-subnet-2"
    "kubernetes.io/cluster/${var.environment}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                               = 1
    Purpose                                                = var.aws_tags["Purpose"]
    Owner                                                  = var.aws_tags["Owner"]
  }
}

resource "aws_subnet" "eks-private-subnet-1" {
  cidr_block        = "10.29.0.0/24"
  vpc_id            = aws_vpc.eks-vpc.id
  availability_zone = "${var.region}a"
  tags = {
    Name                                                   = "${var.environment}-eks-private-subnet-1"
    "kubernetes.io/cluster/${var.environment}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                      = 1
    Purpose                                                = var.aws_tags["Purpose"]
    Owner                                                  = var.aws_tags["Owner"]
  }
}

resource "aws_subnet" "eks-private-subnet-2" {
  cidr_block        = "10.29.1.0/24"
  vpc_id            = aws_vpc.eks-vpc.id
  availability_zone = "${var.region}b"
  tags = {
    Name                                                   = "${var.environment}-eks-private-subnet-2"
    "kubernetes.io/cluster/${var.environment}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                      = 1
    Purpose                                                = var.aws_tags["Purpose"]
    Owner                                                  = var.aws_tags["Owner"]
  }
}