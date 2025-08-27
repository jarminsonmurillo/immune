
resource "aws_launch_configuration" "immune-g2-web-lc-01" {
  name          = "immune-g2-web-lc-01"
  image_id      = "ami-12345678" # Replace with the actual Ubuntu 24.04 LTS AMI ID for us-east-1
  instance_type = "t3.micro"
  security_groups = [
    aws_security_group.immune-g2-web-sg-01.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "immune-g2-web-asg-01" {
  launch_configuration = aws_launch_configuration.immune-g2-web-lc-01.id
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  vpc_zone_identifier  = [
    aws_subnet.immune-g2-private-web-subnet-01.id,
    aws_subnet.immune-g2-private-web-subnet-02.id
  ]
}

resource "aws_launch_configuration" "immune-g2-app-lc-01" {
  name          = "immune-g2-app-lc-01"
  image_id      = "ami-12345678" # Replace with the actual Ubuntu 24.04 LTS AMI ID for us-east-1
  instance_type = "t3.micro"
  security_groups = [
    aws_security_group.immune-g2-app-sg-01.id
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "immune-g2-app-asg-01" {
  launch_configuration = aws_launch_configuration.immune-g2-app-lc-01.id
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  vpc_zone_identifier  = [
    aws_subnet.immune-g2-private-app-subnet-01.id,
    aws_subnet.immune-g2-private-app-subnet-02.id
  ]
}