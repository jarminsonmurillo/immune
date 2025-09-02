resource "aws_lb" "immune-g2-alb-external-01" {
  name               = "immune-g2-alb-external-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.immune-g2-public-lb-sg.id] # Add security group IDs here
  subnets = [
    aws_subnet.immune-g2-public-subnet-01.id,
    aws_subnet.immune-g2-public-subnet-02.id
  ]
  tags = {
    name = "immune-g2-alb-external-01"
  }
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
  security_groups    = [aws_security_group.immune-g2-internal-lb-sg.id] # Add security group IDs here
  subnets = [
    aws_subnet.immune-g2-private-app-subnet-01.id,
    aws_subnet.immune-g2-private-app-subnet-02.id
  ]
  tags = {
    name = "immune-g2-alb-internal-01"
  }
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


# Target Group para el Load Balancer Externo
resource "aws_lb_target_group" "immune-g2-alb-external-tg-01" {
  name        = "immune-g2-alb-external-tg-01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "immune-g2-alb-external-tg-01"
  }
}

# Target Group para el Load Balancer Interno
resource "aws_lb_target_group" "immune-g2-alb-internal-tg-01" {
  name        = "immune-g2-alb-internal-tg-01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "immune-g2-alb-internal-tg-01"
  }
}

# Listener Rule para el Load Balancer Externo
# resource "aws_lb_listener_rule" "immune-g2-alb-external-rule-01" {
#   listener_arn = aws_lb_listener.immune-g2-alb-external-http-01.arn
#   priority     = 100

#   action {
#     type               = "forward"
#     target_group_arn   = aws_lb_target_group.immune-g2-alb-external-tg-01.arn
#   }

#   condition {
#     field  = "path-pattern"
#     values = ["/*"]
#   }
# }

# # Listener Rule para el Load Balancer Interno
# resource "aws_lb_listener_rule" "immune-g2-alb-internal-rule-01" {
#   listener_arn = aws_lb_listener.immune-g2-alb-internal-http-01.arn
#   priority     = 100

#   action {
#     type               = "forward"
#     target_group_arn   = aws_lb_target_group.immune-g2-alb-internal-tg-01.arn
#   }

#   condition {
#     field  = "path-pattern"
#     values = ["/*"]
#   }
# }