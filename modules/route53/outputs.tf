output "hostname" {
  value = trimsuffix("${terraform.workspace}.${data.aws_route53_zone.finlibro.name}", ".")
}

output "aws_route53_record_cert_validation_fqdn" {
  value = aws_route53_record.cert_validation.fqdn
}

output "aws_route53_record_cert_validation_id" {
  value = aws_route53_record.cert_validation.id
}