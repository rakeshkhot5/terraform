resource "aws_launch_configuration" "app_lc" {
  name            = "app-lanuch-config"
  image_id        = var.ami
  instance_type   = var.ec2_instance_class
  key_name        = var.ec2_key_name
  security_groups = ["${aws_security_group.private_sg.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  launch_configuration      = aws_launch_configuration.app_lc.id
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  default_cooldown          = 300
  vpc_zone_identifier       = ["${element(aws_subnet.private.*.id, 0)}", "${element(aws_subnet.private.*.id, 1)}"]


  tag {
    key                 = "Name"
    value               = "ec2-asg"
    propagate_at_launch = true
  }
}
