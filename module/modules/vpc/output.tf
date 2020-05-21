output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "nat_eip" {
  value = "${aws_eip.eip.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public.*.id}"
}

output "web_sg" {
  value = "${aws_security_group.public_sg.id}"
}

output "web_subnet" {
  value = "${length(aws_subnet.public.*.id) > 0 ? element(concat(aws_subnet.public.*.id, list("")), 0) : ""}"
}


output "app_sg" {
  value = "${aws_security_group.private_sg.id}"
}


output "app_subnet" {
  value = "${length(aws_subnet.private.*.id) > 0 ? element(concat(aws_subnet.private.*.id, list("")), 0) : ""}"
}


output "rds_sg" {
  value = "${aws_security_group.rds_sg.id}"
}


output "rds_subnet1" {
  value = "${length(aws_subnet.private.*.id) > 0 ? element(concat(aws_subnet.private.*.id, list("")), 0) : ""}"
}

output "rds_subnet2" {
  value = "${length(aws_subnet.private.*.id) > 0 ? element(concat(aws_subnet.private.*.id, list("")), 1) : ""}"
}

