
# Create a Load Balancer ------------------------------------------------------
resource "aws_lb" "load_balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_sg.id]
  subnets            = [aws_subnet.public_subnet_01.id, aws_subnet.public_subnet_02.id]

  enable_deletion_protection = false
  tags = {
    name = "load-balancer"
  }
}

# Create a Load Balancer Target Group -----------------------------------------

resource "aws_lb_target_group" "alb_target" {
  name        = "alb-targets"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc_01.id
}

# Create a Load Balancer Listener ---------------------------------------------
resource "aws_lb_listener" "lb_listner" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  tags = {
    name = "listener"
  }
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}


