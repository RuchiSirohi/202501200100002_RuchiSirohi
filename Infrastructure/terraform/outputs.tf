output "alb_dns_name" {
  description = "Public DNS name of the CloudNotes Application Load Balancer"
  value       = aws_lb.cloudnotes_alb.dns_name
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = aws_db_instance.cloudnotes_db.address
}

output "autoscaling_group_name" {
  description = "CloudNotes Auto Scaling Group name"
  value       = aws_autoscaling_group.cloudnotes_asg.name
}

output "vpc_id" {
  description = "CloudNotes VPC ID"
  value       = aws_vpc.cloudnotes_vpc.id
}