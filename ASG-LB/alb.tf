resource "aws_lb_target_group" "my_tg" {
  name     = "my-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "my-tg"
  }
}

resource "aws_alb" "my-alb" {
  name                             = "my-alb"
  ip_address_type                  = "ipv4"
  internal                         = "false"
  security_groups                  = ["${aws_security_group.my-alb-sg.id}"]
  subnets                          = ["${element(aws_subnet.public.*.id, 0)}", "${element(aws_subnet.public.*.id, 1)}"]
  enable_cross_zone_load_balancing = "true"

  tags = {
    Name = "my-alb"
  }
}

resource "aws_lb_listener" "my-alb-listner" {
  load_balancer_arn = aws_alb.my-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}
