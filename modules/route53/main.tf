//@formatter:off

data "aws_elastic_beanstalk_hosted_zone" "current" {}

data "aws_route53_zone" "finlibro" {
    zone_id = "ZPTR9WSOVSELF"
}

resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.finlibro.zone_id
  name    = "${terraform.workspace}.${data.aws_route53_zone.finlibro.name}"
  type    = "A"

  alias {
     name    = var.finlibro-accounting-cname
     zone_id = data.aws_elastic_beanstalk_hosted_zone.current.id
     evaluate_target_health = false
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = var.domain_validation_options_resource_record_name
  type    = var.domain_validation_options_resource_record_type
  zone_id = data.aws_route53_zone.finlibro.zone_id
  records = [
    var.domain_validation_options_resource_record_value
  ]
  ttl     = 60
}
//@formatter:on
