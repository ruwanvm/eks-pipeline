resource "aws_iam_role" "eks-cluster-role" {
  name               = "${var.environment}-eks-cluster-role"
  tags               = var.aws_tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "aws-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "aws-eks-vpc-resource-controller-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.environment}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = [
      aws_subnet.eks-public-subnet-1.id,
      aws_subnet.eks-public-subnet-2.id,
      aws_subnet.eks-private-subnet-1.id,
      aws_subnet.eks-private-subnet-2.id
    ]
  }
  tags = {
    Name    = "${var.environment}-eks-cluster"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
  depends_on = [
    aws_iam_role_policy_attachment.aws-eks-cluster-policy,
    aws_iam_role_policy_attachment.aws-eks-vpc-resource-controller-policy,
  ]
}
