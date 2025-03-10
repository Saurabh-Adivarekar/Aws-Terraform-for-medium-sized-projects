## CloudFront access to S3 IAM policy

data "aws_iam_policy_document" "cloudfront_s3_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${module.s3.s3_bucket_arn}/*",
    ]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "AWS:SourceArn"
      values   = [module.cloudfront.cloudfront_arn]
    }
  }
}

## S3 module

module "s3" {
  source = "../../../Module/s3"

  bucket_name   = var.s3_bucket_name
  cors_rule     = var.s3_cors_rule
  bucket_policy = data.aws_iam_policy_document.cloudfront_s3_policy.json
}