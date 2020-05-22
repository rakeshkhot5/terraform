resource "aws_efs_file_system" "foo" {
  creation_token = "my-product"

  tags = {
    Name = "MyProduct"
  }
}


resource "aws_efs_mount_target" "alpha" {
  file_system_id = aws_efs_file_system.foo.id
  subnet_id      = aws_subnet.alpha.id
}

resource "aws_vpc" "foo" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "alpha" {
  vpc_id            = aws_vpc.foo.id
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_efs_file_system" "foo_with_lifecyle_policy" {
  creation_token = "my-product"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}
