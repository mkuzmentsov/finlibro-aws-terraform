output "finlibro-accounting-url" {

  value = aws_elastic_beanstalk_environment.finlibro-accounting.endpoint_url
}

output "finlibro-integrations-arn" {

  value = aws_elastic_beanstalk_environment.finlibro-integrations.arn
}

output "finlibro-accounting-cname" {

  value = aws_elastic_beanstalk_environment.finlibro-accounting.cname
}

output "finlibro-accounting-loadbalancers" {

  value = aws_elastic_beanstalk_environment.finlibro-accounting.load_balancers
}