resource "aws_vpc" "eks-vpc" {
  cidr_block                       = "10.29.0.0/16"
  instance_tenancy                 = "default" # Makes instances on VPC shared on the host.
  enable_dns_support               = true      # Required for EKS. Enable/disable DNS support in the VPC.
  enable_dns_hostnames             = true      # Required for EKS. Enable/disable DNS hostnames in the VPC.
  enable_classiclink               = false     # Enable/disable ClassicLink for the VPC.
  enable_classiclink_dns_support   = false     # Enable/disable ClassicLink DNS Support for the VPC.
  assign_generated_ipv6_cidr_block = false     # Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC.
  tags = {
    Name    = "${var.environment}-eks-vpc"
    Purpose = var.aws_tags["Purpose"]
    Owner   = var.aws_tags["Owner"]
  }
}