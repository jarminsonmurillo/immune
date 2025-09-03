# Launch Template para el Web Tier
resource "aws_launch_template" "immune-g2-web-lt-01" {
  name          = "immune-g2-web-lt-01"
  image_id      = "ami-0360c520857e3138f" # Replace with the actual Ubuntu 24.04 LTS AMI ID for us-east-1
  instance_type = "t3.micro"
  key_name      = "capstone-key-pair"

  network_interfaces {
    security_groups = [aws_security_group.immune-g2-web-sg-01.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "immune-g2-web-instance"
    }
  }
}

# Auto Scaling Group para el Web Tier
resource "aws_autoscaling_group" "immune-g2-web-asg-01" {
  launch_template {
    id      = aws_launch_template.immune-g2-web-lt-01.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.immune-g2-alb-external-tg-01.arn]
  min_size          = 2
  max_size          = 2
  desired_capacity  = 2
  vpc_zone_identifier = [
    aws_subnet.immune-g2-private-web-subnet-01.id,
    aws_subnet.immune-g2-private-web-subnet-02.id
  ]

  tag {
    key                 = "Name"
    value               = "immune-g2-web-instance"
    propagate_at_launch = true
  }
}

# Launch Template para el App Tier
resource "aws_launch_template" "immune-g2-app-lt-01" {
  name          = "immune-g2-app-lt-01"
  image_id      = "ami-0360c520857e3138f" # Replace with the actual Ubuntu 24.04 LTS AMI ID for us-east-1
  instance_type = "t3.micro"
  key_name      = "capstone-key-pair"

  network_interfaces {
    security_groups = [aws_security_group.immune-g2-app-sg-01.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "immune-g2-app-instance"
    }
  }
}

# Auto Scaling Group para el App Tier
resource "aws_autoscaling_group" "immune-g2-app-asg-01" {
  launch_template {
    id      = aws_launch_template.immune-g2-app-lt-01.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.immune-g2-alb-internal-tg-01.arn]
  min_size          = 2
  max_size          = 2
  desired_capacity  = 2
  vpc_zone_identifier = [
    aws_subnet.immune-g2-private-app-subnet-01.id,
    aws_subnet.immune-g2-private-app-subnet-02.id
  ]

  tag {
    key                 = "Name"
    value               = "immune-g2-app-instance"
    propagate_at_launch = true
  }
}