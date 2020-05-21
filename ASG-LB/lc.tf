resource "aws_launch_configuration" "app_lc" {
  name            = "app-lanuch-config"
  image_id        = var.ami
  instance_type   = var.ec2_instance_class
  key_name        = var.ec2_key_name
  security_groups = ["${aws_security_group.private_sg.id}"]
  user_data       = file("install_apache.sh")

  lifecycle {
    create_before_destroy = true
  }
}
