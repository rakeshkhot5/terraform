module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = "prod"
  vpc_cidr             = "192.168.0.0/16"
  vpc_id               = "${module.vpc.vpc_id}"
  public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  igw_name             = "prod-uigw"
  nat_eip              = "${module.vpc.nat_eip}"
}

module "ec2-web" {
  source             = "./modules/ec2-web"
  ami                = "ami-068663a3c619dd892"
  ec2_instance_class = "t2.micro"
  ec2_key_name       = "windows"
  ec2_tag            = "web"
  web_subnet         = "${module.vpc.web_subnet}"
  web_sg             =  "${module.vpc.web_sg}"
}


module "ec2-app" {
  source             = "./modules/ec2-app"
  ami                = "ami-068663a3c619dd892"
  ec2_instance_class = "t2.micro"
  ec2_key_name       = "windows"
  ec2_tag            = "app"
  app_subnet         = "${module.vpc.app_subnet}"
  app_sg             =  "${module.vpc.app_sg}"
}


module "rds" {
  source             = "./modules/rds"
  db_instance_class  = "db.t2.micro"
  rds_subnet1         = "${module.vpc.rds_subnet1}"
  rds_subnet2        = "${module.vpc.rds_subnet2}"
  rds_sg             =  "${module.vpc.rds_sg}"
}
