resource "aws_lb" "immune-g2-alb-external-01" {
  name               = "immune-g2-alb-external-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [] # Add security group IDs here
  subnets            = [
    aws_subnet.immune-g2-public-subnet-01.id,
    aws_subnet.immune-g2-public-subnet-02.id
  ]
}

resource "aws_lb_listener" "immune-g2-alb-external-http-01" {
  load_balancer_arn = aws_lb.immune-g2-alb-external-01.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Default response"
      status_code  = "200"
    }
  }
}

resource "aws_lb" "immune-g2-alb-internal-01" {
  name               = "immune-g2-alb-internal-01"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [] # Add security group IDs here
  subnets            = [
    aws_subnet.immune-g2-private-app-subnet-01.id,
    aws_subnet.immune-g2-private-app-subnet-02.id
  ]
}

resource "aws_lb_listener" "immune-g2-alb-internal-http-01" {
  load_balancer_arn = aws_lb.immune-g2-alb-internal-01.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Internal default response"
      status_code  = "200"
    }
  }
}