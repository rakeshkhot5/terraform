resource "aws_route53_zone" "my_domain" {
  name = "mydomain.com"

}

resource "aws_route53_record" "web" {
  name    = "abc"
  zone_id = aws_route53_zone.my_domain.id
  records = ["1.1.1.1"]
  type    = "A"
  ttl     = "300"

}
