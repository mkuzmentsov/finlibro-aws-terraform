resource "aws_elastic_beanstalk_application" "FinLibro" {
    name        = "FinLibro"
}

resource "aws_elastic_beanstalk_environment" "finlibro-accounting" {
    name                = "FinLibro-Accounting"
    application         = aws_elastic_beanstalk_application.FinLibro.name
    solution_stack_name = "64bit Amazon Linux 2 v5.5.5 running Node.js 14"
    tier = "WebServer"

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name      = "EnvironmentType"
        value     = "LoadBalanced" // LoadBalanced / SingleInstance
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name      = "EnvironmentType"
        value     = "LoadBalanced"  // LoadBalanced / SingleInstance
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name      = "LoadBalancerType"
        value     = "application"
    }

    setting {
        namespace = "aws:elasticbeanstalk:application"
        name      = "Application Healthcheck URL"
        value     = "/app/health"
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "VPCId"
        value     = var.finlibro-vpc-id
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "ELBSubnets"
        value     = join(",", [var.finlibro-public-1-network-id, var.finlibro-public-2-network-id])
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "Subnets"
        value     = "${var.finlibro-public-1-network-id},${var.finlibro-public-2-network-id}"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "beanstalk-ec2-user"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "InstanceType"
        value = "t3a.nano"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "EC2KeyName"
        value = "finlibro-ssh-www-aws"
    }

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "Protocol"
        value     = "HTTPS"
    }

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "SSLCertificateArns"
        value     = var.loadbalancer_certificate_validation_arn
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "StreamLogs"
        value = "true"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "DeleteOnTerminate"
        value = "true"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "RetentionInDays"
        value = "3"
    }
}

resource "aws_elastic_beanstalk_environment" "finlibro-integrations" {
    name                = "FinLibro-Integrations"
    application         = aws_elastic_beanstalk_application.FinLibro.name
    solution_stack_name = "64bit Amazon Linux 2 v5.5.5 running Node.js 14"
    tier = "Worker"

    setting {
        namespace = "aws:ec2:vpc"
        name      = "VPCId"
        value     = var.finlibro-vpc-id
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "Subnets"
        value     = var.finlibro-integrations-single-instance-setup ? "${var.finlibro-public-1-network-id},${var.finlibro-public-2-network-id}" : "${var.finlibro-private-1-network-id},${var.finlibro-private-2-network-id}"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "beanstalk-ec2-user"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "InstanceType"
        value = "t3a.nano"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "EC2KeyName"
        value = "finlibro-ssh-www-aws"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "StreamLogs"
        value = "true"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "DeleteOnTerminate"
        value = "true"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name = "RetentionInDays"
        value = "3"
    }
}
