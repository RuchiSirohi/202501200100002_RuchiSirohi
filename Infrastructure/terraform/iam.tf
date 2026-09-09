# ==========================================
# Get Current AWS Account
# ==========================================

data "aws_caller_identity" "current" {}

# ==========================================
# IAM Role for EC2
# ==========================================

resource "aws_iam_role" "ec2_role" {
  name = "cloudnotes-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "cloudnotes-ec2-role"
  }
}

# ==========================================
# CloudWatch Policy
# ==========================================

resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# ==========================================
# Systems Manager Policy
# ==========================================

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ==========================================
# ECR Read-Only Policy
# ==========================================

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# ==========================================
# Custom Policy for Database Password
# ==========================================

resource "aws_iam_role_policy" "database_parameter_policy" {
  name = "cloudnotes-database-parameter-access"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "ssm:GetParameter"
        ]

        Resource = "arn:aws:ssm:ap-south-1:${data.aws_caller_identity.current.account_id}:parameter/cloudnotes/database/*"
      }
    ]
  })
}

# ==========================================
# EC2 Instance Profile
# ==========================================

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "cloudnotes-ec2-profile"
  role = aws_iam_role.ec2_role.name
}