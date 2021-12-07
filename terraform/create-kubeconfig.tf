locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${aws_eks_cluster.eks-cluster.certificate_authority[0].data}
    server: ${aws_eks_cluster.eks-cluster.endpoint}
  name: ${aws_eks_cluster.eks-cluster.arn}
contexts:
- context:
    cluster: ${aws_eks_cluster.eks-cluster.arn}
    user: ${aws_eks_cluster.eks-cluster.arn}
  name: ${aws_eks_cluster.eks-cluster.arn}
current-context: ${aws_eks_cluster.eks-cluster.arn}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.eks-cluster.arn}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - --region
      - ${var.region}
      - eks
      - get-token
      - --cluster-name
      - ${var.environment}-eks-cluster
      command: aws
KUBECONFIG
}

resource "local_file" "kubeconfig-file" {
  content  = local.kubeconfig
  filename = "../tmp/kubeconfig"
}