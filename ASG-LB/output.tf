output "lb_address" {
  value = aws_alb.my-alb.dns_name
}
