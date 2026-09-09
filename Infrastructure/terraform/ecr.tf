# ==========================================
# Amazon ECR Repository
# ==========================================

resource "aws_ecr_repository" "cloudnotes_repo" {
  name                 = "cloudnotes"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "cloudnotes-ecr"
  }
}