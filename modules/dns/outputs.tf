output "url" {
  value       = aws_route53_record.dns.fqdn
  description = "The URL of the record"
}