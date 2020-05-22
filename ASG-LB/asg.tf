resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  launch_configuration      = aws_launch_configuration.app_lc.id
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  target_group_arns         = ["${aws_lb_target_group.my_tg.arn}"]
  desired_capacity          = var.desired_capacity
  force_delete              = true
  default_cooldown          = 300
  vpc_zone_identifier       = ["${element(aws_subnet.private.*.id, 0)}", "${element(aws_subnet.private.*.id, 1)}"]

  tag {
    key                 = "Name"
    value               = "ec2-asg"
    propagate_at_launch = true
  }
}
