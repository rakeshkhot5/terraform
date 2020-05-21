variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnets_cidr" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "ami" {
  default = "ami-068663a3c619dd892"
}

variable "ec2_instance_class" {
  default = "t2.micro"
}

variable "ec2_web_privateip" {
  default = "10.0.1.5"
}

variable "ec2_key_name" {
  default = "windows"
}

variable "db_instance_class" {
  default = "db.t2.micro"
}
