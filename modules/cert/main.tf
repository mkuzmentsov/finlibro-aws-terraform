resource "aws_acm_certificate" "cert" {
    domain_name       = var.hostname
    validation_method = "DNS"

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_acm_certificate_validation" "cert_validation" {
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [var.aws_route53_record_cert_validation_fqdn]
}