output "eb-instance-profile" {

  value = aws_iam_instance_profile.beanstalk_ec2.name
}

output "aws-iam-role-id" {

  value = aws_iam_role.beanstalk_ec2.id
}

output "aws-beanstalk_ec2-role-arn" {

  value = aws_iam_role.beanstalk_ec2.arn
}

output "aws-beanstalk_ec2-instance-profile-arn" {

  value = aws_iam_instance_profile.beanstalk_ec2.arn
}

output "aws-beanstalk_service-role-arn" {

  value = aws_iam_role.beanstalk_service.arn
}