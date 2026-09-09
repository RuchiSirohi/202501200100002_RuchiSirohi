data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


resource "aws_launch_template" "cloudnotes_launch_template" {

  name_prefix = "cloudnotes-"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]


  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Update system
    dnf update -y

    # Install required packages
    dnf install -y docker git

    # Start Docker
    systemctl enable docker
    systemctl start docker

    # Clone CloudNotes application
    cd /home/ec2-user

    git clone https://github.com/RuchiSirohi/202501200100002_RuchiSirohi.git cloudnotes-app

    # Move into application directory
    cd cloudnotes-app/Application

    # Build Docker image
    docker build -t cloudnotes -f backend/Dockerfile .


    # Get database password from AWS Systems Manager Parameter Store
    DB_PASSWORD=$(aws ssm get-parameter \
      --name "/cloudnotes/database/password" \
      --with-decryption \
      --query "Parameter.Value" \
      --output text \
      --region ap-south-1)


    # Run CloudNotes container
    docker run -d \
      --name cloudnotes \
      --restart unless-stopped \
      -p 3000:3000 \
      -e PORT=3000 \
      -e DB_HOST="${aws_db_instance.cloudnotes_db.address}" \
      -e DB_PORT=3306 \
      -e DB_USER="cloudnotes_user" \
      -e DB_PASSWORD="$DB_PASSWORD" \
      -e DB_NAME="cloudnotes" \
      cloudnotes


    echo "CloudNotes application deployment completed."

  EOF
  )


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "cloudnotes-app-server"
    }
  }


  depends_on = [
    aws_db_instance.cloudnotes_db,
    aws_ssm_parameter.db_password
  ]
}


resource "aws_autoscaling_group" "cloudnotes_asg" {

  name = "cloudnotes-asg"

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  health_check_type = "ELB"

  vpc_zone_identifier = [
    aws_subnet.private_app_subnet_1.id,
    aws_subnet.private_app_subnet_2.id
  ]

  launch_template {
    id      = aws_launch_template.cloudnotes_launch_template.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.cloudnotes_target_group.arn
  ]

  tag {
    key                 = "Name"
    value               = "cloudnotes-app-server"
    propagate_at_launch = true
  }

  depends_on = [
    aws_lb_listener.cloudnotes_listener
  ]
}