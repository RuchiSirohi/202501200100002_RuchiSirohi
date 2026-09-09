# ==========================================
# ALB Security Group
# ==========================================

resource "aws_security_group" "alb_sg" {
  name        = "cloudnotes-alb-sg"
  description = "Security group for CloudNotes Application Load Balancer"
  vpc_id      = aws_vpc.cloudnotes_vpc.id

  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudnotes-alb-sg"
  }
}


# ==========================================
# EC2 Security Group
# ==========================================

resource "aws_security_group" "app_sg" {
  name        = "cloudnotes-app-sg"
  description = "Security group for CloudNotes EC2 instances"
  vpc_id      = aws_vpc.cloudnotes_vpc.id

  ingress {
    description     = "Allow CloudNotes traffic from ALB"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudnotes-app-sg"
  }
}


# ==========================================
# RDS Security Group
# ==========================================

resource "aws_security_group" "db_sg" {
  name        = "cloudnotes-db-sg"
  description = "Security group for CloudNotes RDS MySQL"
  vpc_id      = aws_vpc.cloudnotes_vpc.id

  ingress {
    description     = "Allow MySQL from application servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloudnotes-db-sg"
  }
}