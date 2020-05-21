variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {}

variable "vpc_id" {}

variable "igw_name" {}

variable "nat_eip" {}

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
