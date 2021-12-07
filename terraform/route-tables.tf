// Create route tables for subnets
resource "aws_route_table" "eks-public-route-table" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }
  tags = {
    Name    = "${var.environment}-eks-public-route-table"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}

resource "aws_route_table" "eks-private-route-table-1" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1.id
  }
  tags = {
    Name    = "${var.environment}-eks-private-route-table-1"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}

resource "aws_route_table" "eks-private-route-table-2" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-2.id
  }
  tags = {
    Name    = "${var.environment}-eks-private-route-table-2"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}

// Route tables association to Public and Private subnets
resource "aws_route_table_association" "eks-public-route-table-association-1" {
  subnet_id      = aws_subnet.eks-public-subnet-1.id
  route_table_id = aws_route_table.eks-public-route-table.id
}

resource "aws_route_table_association" "eks-public-route-table-association-2" {
  subnet_id      = aws_subnet.eks-public-subnet-2.id
  route_table_id = aws_route_table.eks-public-route-table.id
}

resource "aws_route_table_association" "eks-private-route-table-association-1" {
  subnet_id      = aws_subnet.eks-private-subnet-1.id
  route_table_id = aws_route_table.eks-private-route-table-1.id
}

resource "aws_route_table_association" "eks-private-route-table-association-2" {
  subnet_id      = aws_subnet.eks-private-subnet-2.id
  route_table_id = aws_route_table.eks-private-route-table-2.id
}