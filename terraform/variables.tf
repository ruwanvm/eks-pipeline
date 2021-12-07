variable "environment" {
  description = "Environment Name"
}
variable "region" {
  description = "region to create new EKS cluster and ECR"
}

variable "aws_tags" {
  type = map(string)
  default = {
    Purpose = "POC-terrafom-ansible-automation"
    Owner   = "ruwan.mettananda"
  }
}