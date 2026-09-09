# ==========================================
# Application Load Balancer
# ==========================================

resource "aws_lb" "cloudnotes_alb" {
  name               = "cloudnotes-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb_sg.id
  ]

  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  tags = {
    Name = "cloudnotes-alb"
  }
}

# ==========================================
# Target Group
# ==========================================

resource "aws_lb_target_group" "cloudnotes_target_group" {
  name     = "cloudnotes-target-group"
  port     = 3000
  protocol = "HTTP"

  vpc_id = aws_vpc.cloudnotes_vpc.id

  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/api/health"
    protocol            = "HTTP"
    port                = "3000"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name = "cloudnotes-target-group"
  }
}

# ==========================================
# HTTP Listener
# ==========================================

resource "aws_lb_listener" "cloudnotes_listener" {
  load_balancer_arn = aws_lb.cloudnotes_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cloudnotes_target_group.arn
  }
}