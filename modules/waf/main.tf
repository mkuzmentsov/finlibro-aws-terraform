resource "aws_wafv2_web_acl" "finlibro-wafv2-acl" {
    name        = "finlibro-${terraform.workspace}-wafv2"
    description = "FinLibro WAFv2 Web ACL"
    scope       = "REGIONAL"

    default_action {
        allow {}
    }

    rule {
        name     = "FinLibro_Rule_To_Allow_MonobankRequests"
        priority = 1

        action {
            allow {}
        }

        statement {
            and_statement {
                statement {
                    byte_match_statement {
                        field_to_match {
                            uri_path {}
                        }
                        positional_constraint = "STARTS_WITH"
                        search_string         = "/api/v1/integration/monobank/"
                        text_transformation {
                            priority = 0
                            type     = "NONE"
                        }
                    }
                }
                statement {
                    byte_match_statement {
                        field_to_match {
                            method {}
                        }
                        positional_constraint = "EXACTLY"
                        search_string         = "GET"
                        text_transformation {
                            priority = 0
                            type     = "NONE"
                        }
                    }
                }
                statement {
                    size_constraint_statement {
                        field_to_match {
                            single_header {
                                name = "x-request-id"
                            }
                        }
                        comparison_operator = "GT"
                        size                = 1
                        text_transformation {
                            priority = 0
                            type     = "NONE"
                        }
                    }
                }
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "finlibro-accounting-FinLibro_Rule_To_Allow_MonobankRequests-metric"
            sampled_requests_enabled   = true
        }
    }

    rule {
        name     = "FinLibro-AWSManagedRulesCommonRuleSet"
        priority = 2

        override_action {
            none {}
        }

        statement {
            managed_rule_group_statement {
                name        = "AWSManagedRulesCommonRuleSet"
                vendor_name = "AWS"
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "finlibro-accounting-AWSManagedRulesCommonRuleSet-metric"
            sampled_requests_enabled   = true
        }
    }

    rule {
        name     = "FinLibro-AWSManagedRulesLinuxRuleSet"
        priority = 3

        override_action {
            none {}
        }

        statement {
            managed_rule_group_statement {
                name        = "AWSManagedRulesLinuxRuleSet"
                vendor_name = "AWS"
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "finlibro-accounting-AWSManagedRulesLinuxRuleSet-metric"
            sampled_requests_enabled   = true
        }
    }

    rule {
        name     = "FinLibro-AWSManagedRulesPHPRuleSet"
        priority = 4

        override_action {
            none {}
        }

        statement {
            managed_rule_group_statement {
                name        = "AWSManagedRulesPHPRuleSet"
                vendor_name = "AWS"
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "finlibro-accounting-AWSManagedRulesPHPRuleSet-metric"
            sampled_requests_enabled   = true
        }
    }

    rule {
        name     = "FinLibro-AWSManagedRulesAmazonIpReputationList"
        priority = 5

        override_action {
            none {}
        }

        statement {
            managed_rule_group_statement {
                name        = "AWSManagedRulesAmazonIpReputationList"
                vendor_name = "AWS"
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "finlibro-accounting-AWSManagedRulesAmazonIpReputationList-metric"
            sampled_requests_enabled   = true
        }
    }

    rule {
        name     = "FinLibro-AWSManagedRulesKnownBadInputsRuleSet"
        priority = 6

        override_action {
            none {}
        }

        statement {
            managed_rule_group_statement {
                name        = "AWSManagedRulesKnownBadInputsRuleSet"
                vendor_name = "AWS"
            }
        }

        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "finlibro-accounting-AWSManagedRulesKnownBadInputsRuleSet-metric"
            sampled_requests_enabled   = true
        }
    }


    tags = {
        Namespace = terraform.workspace
    }

    visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "finlibro-accounting-wafv2-request-metric"
        sampled_requests_enabled   = false
    }
}

resource "aws_wafv2_web_acl_association" "finlibro_accounting_wafv2_elb_association" {
    resource_arn = var.finlibro-accounting-alb-arn
    web_acl_arn  = aws_wafv2_web_acl.finlibro-wafv2-acl.arn
}