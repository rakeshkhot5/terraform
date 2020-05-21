variable "aws_region" {
  default = "us-east-1"
}

variable "username" {
  type = list(string)
  default = ["local", "qa", "stage"]
}
