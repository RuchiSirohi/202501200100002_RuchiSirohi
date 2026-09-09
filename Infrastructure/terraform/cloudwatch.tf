resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "cloudnotes-asg-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic            = "Average"
  threshold           = 70

  alarm_description = "Alarm when CloudNotes EC2 CPU exceeds 70%"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.cloudnotes_asg.name
  }
}