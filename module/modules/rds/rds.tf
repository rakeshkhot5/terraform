resource "aws_db_instance" "test-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.db_instance_class
  name                   = "test"
  identifier             = "test-rds"
  username               = "spring"
  password               = "$pring321"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.id
  vpc_security_group_ids = [var.rds_sg]
  skip_final_snapshot    = "true"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["${var.rds_subnet1}", "${var.rds_subnet2}"]

  tags = {
    Name = "RDS subnet group"
  }
}
