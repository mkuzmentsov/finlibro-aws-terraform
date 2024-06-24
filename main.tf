terraform {
  backend "s3" {
    bucket = "finlibro-terraform-app-env-workspaces"
    key    = "keyfile"
    region = "eu-central-1"
  }
}

module "s3" {
  source = "./modules/s3"
  aws-beanstalk_ec2-role-arn = module.roles.aws-beanstalk_ec2-role-arn
  aws-beanstalk_service-role-arn = module.roles.aws-beanstalk_service-role-arn
}

module "route53" {
  source = "./modules/route53"
  finlibro-accounting-cname = module.elasticbeanstalk.finlibro-accounting-cname
  domain_validation_options_resource_record_name = module.cert.domain_validation_options.0.resource_record_name
  domain_validation_options_resource_record_type = module.cert.domain_validation_options.0.resource_record_type
  domain_validation_options_resource_record_value = module.cert.domain_validation_options.0.resource_record_value
}

module "cert" {
  source = "./modules/cert"
  hostname = module.route53.hostname
  aws_route53_record_cert_validation_fqdn = module.route53.aws_route53_record_cert_validation_fqdn
}

module "elasticbeanstalk" {
  source = "./modules/elasticbeanstalk"
  finlibro-private-1-network-id = module.network.finlibro-private-1-network-id
  finlibro-private-2-network-id = module.network.finlibro-private-2-network-id
  finlibro-public-1-network-id = module.network.finlibro-public-1-network-id
  finlibro-public-2-network-id = module.network.finlibro-public-2-network-id
  finlibro-vpc-id = module.network.finlibro-vpc-id
  loadbalancer_certificate_validation_arn = module.cert.loadbalancer_certificate_validation_arn
  finlibro-integrations-single-instance-setup = var.finlibro-integrations-single-instance-setup
}

module "network" {
  source = "./modules/network"
}

module "no-nat-network" {
  count = var.finlibro-integrations-single-instance-setup ? 1 : 0
  source = "./modules/no-nat-network"

  finlibro-nat-eip-allocation-id = var.finlibro-nat-eip-allocation-id
  finlibro-integrations-eb-arn = module.elasticbeanstalk.finlibro-integrations-arn
}

module "nat-network" {
  count = var.finlibro-integrations-single-instance-setup ? 0 : 1
  source = "./modules/nat-network"

  finlibro-nat-eip-allocation-id = var.finlibro-nat-eip-allocation-id
  finlibro-network-finlibro-private-1-id = module.network.finlibro-private-1-network-id
  finlibro-network-finlibro-private-2-id = module.network.finlibro-private-2-network-id
  finlibro-network-finlibro-public-1-id = module.network.finlibro-public-1-network-id
  finlibro-network-finlibro-public-2-id = module.network.finlibro-public-2-network-id
  finlibro-vpc-id = module.network.finlibro-vpc-id
  finlibro-internet-gateway-id = module.network.finlibro-internet-gateway-id
}

module "roles" {
  source = "./modules/roles"
}

module "waf" {
  source = "./modules/waf"
  finlibro-accounting-alb-arn = module.elasticbeanstalk.finlibro-accounting-loadbalancers.0
  count = 0
}

# Specify the provider and access details
provider "aws" {
  version = "3.74.0"
  region = "eu-central-1"
}



####################
