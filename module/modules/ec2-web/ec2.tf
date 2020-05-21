resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.ec2_instance_class
  key_name               = var.ec2_key_name
  vpc_security_group_ids = [var.web_sg]
  subnet_id              = var.web_subnet

  tags = {
    Name = var.ec2_tag
  }

  lifecycle {
    create_before_destroy = "true"
  }
}
