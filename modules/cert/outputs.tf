output "loadbalancer_certificate_arn" {
  value = aws_acm_certificate.cert.id
}

output "domain_validation_options" {
  value = tolist(aws_acm_certificate.cert.domain_validation_options)
}

output "loadbalancer_certificate_validation_arn" {
  value = aws_acm_certificate_validation.cert_validation.certificate_arn
}