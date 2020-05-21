output "web_public_ip" {
  value = "${module.ec2-web.public_ip}"
}


output "app_private_ip" {
  value = "${module.ec2-app.private_ip}"
}

output "rds_url" {
  value = "${module.rds.rds_url}"
}
