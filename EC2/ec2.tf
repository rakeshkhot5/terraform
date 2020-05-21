# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"

resource "aws_instance" "web" {
  count           = length(var.public_subnets_cidr)
  ami             = var.ami
  instance_type   = var.ec2_instance_class
  key_name        = var.ec2_key_name
  security_groups = ["${aws_security_group.public_sg.id}"]
  subnet_id       = element(aws_subnet.public.*.id, count.index + 0)

  tags = {
    Name = "web"
  }

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "aws_instance" "app" {
  count           = length(var.private_subnets_cidr)
  ami             = var.ami
  instance_type   = var.ec2_instance_class
  key_name        = var.ec2_key_name
  security_groups = ["${aws_security_group.private_sg.id}"]
  subnet_id       = element(aws_subnet.private.*.id, count.index + 0)

  tags = {
    Name = "app"
  }

  lifecycle {
    create_before_destroy = "true"
  }
}
