resource "aws_iam_role" "eks-node-group-role" {
  name               = "${var.environment}-eks-node-group-role"
  tags               = var.aws_tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "aws-eks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "aws-eks-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "aws-ec2-container-registry-read-only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_eks_node_group" "eks-node-group-micro" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "${var.environment}-node-group-micro"
  node_role_arn   = aws_iam_role.eks-node-group-role.arn
  subnet_ids = [
    aws_subnet.eks-private-subnet-1.id,
    aws_subnet.eks-private-subnet-2.id
  ]
  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }
  ami_type             = "AL2_x86_64"
  disk_size            = 20
  force_update_version = false
  instance_types = [
    "t3.small"
  ]
  labels = {
    role = "eks-node-group-role"
  }
  depends_on = [
    aws_iam_role_policy_attachment.aws-eks-node-policy,
    aws_iam_role_policy_attachment.aws-eks-cni-policy,
    aws_iam_role_policy_attachment.aws-ec2-container-registry-read-only
  ]
  tags = {
    Name    = "${var.environment}-eks-node-micro"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}
