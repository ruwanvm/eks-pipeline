resource "aws_ecr_repository" "current_repository" {
  name                 = "current"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.aws_tags
}

resource "aws_ecr_repository" "hourly_repository" {
  name                 = "hourly"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.aws_tags
}

resource "aws_ecr_repository" "daily_repository" {
  name                 = "daily"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = var.aws_tags
}