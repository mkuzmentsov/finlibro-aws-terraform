//@formatter:off
data "aws_s3_bucket" "finlibro" {
  bucket = "finlibro"
}

resource "aws_s3_bucket_policy" "finlibro" {
  bucket = data.aws_s3_bucket.finlibro.id

  policy = <<POLICY
{
    "Id": "Policy1111Blah",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1440Blah",
            "Action": [
                "s3:*"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::${data.aws_s3_bucket.finlibro.bucket}/*",
            "Principal": {
                "AWS": [
                    "${var.aws-beanstalk_ec2-role-arn}",
                    "${var.aws-beanstalk_service-role-arn}"
                ]
            }
        }
    ]
}
POLICY
}

//@formatter:on
