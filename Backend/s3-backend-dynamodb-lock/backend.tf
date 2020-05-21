terraform {
  backend "s3" {
    bucket                  = "mybucket6458"
    key                     = "terraform.tfstate"
    region                  = "us-east-1"
    shared_credentials_file = "~/.aws/config"
    profile                 = "demo.springct"
    dynamodb_table          = "terraform-lock"
  }
}
