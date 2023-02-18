#DNS Configuration
#Get already , publicly configured Hosted Zone on Route53 - MUST EXIST
data "aws_route53_zone" "dns" {
  name = var.domain_name
}

resource "aws_route53_record" "dns" {
  zone_id = data.aws_route53_zone.dns.zone_id
  name    = "${var.subdomain}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [var.server_ip]
}