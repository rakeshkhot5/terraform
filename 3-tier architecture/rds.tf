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
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  skip_final_snapshot    = "true"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = ["${element(aws_subnet.private.*.id, 0)}", "${element(aws_subnet.private.*.id, 1)}"]

  tags = {
    Name = "RDS subnet group"
  }
}

## Security Group for RDS server

resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

## Mysql access from vpc only (private)
resource "aws_security_group_rule" "rds-sg-rule" {
  from_port         = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  to_port           = 3306
  type              = "ingress"
  cidr_blocks       = ["${var.vpc_cidr}"]
}
