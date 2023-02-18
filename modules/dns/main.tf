#DNS Configuration
#Get already , publicly configured Hosted Zone on Route53 - MUST EXIST

locals {
  domain_name = "${var.subdomain}.${var.domain_name}"
}

data "aws_route53_zone" "dns" {
  name = var.domain_name
}

resource "aws_route53_record" "dns" {
  zone_id = data.aws_route53_zone.dns.zone_id
  name    = local.domain_name
  type    = "A"
  ttl     = "300"
  records = [var.server_ip]
}

resource "local_file" "ssl_setup" {
  content         = templatefile("${var.source_root_dir}/templates/ssl-setup.tpl", { domain_name = local.domain_name })
  filename        = "${var.source_root_dir}/scripts/ssl_setup.sh"
  file_permission = "0755"
}