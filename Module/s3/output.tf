## Outputs

output "s3_bucket_name" {
  value = aws_s3_bucket.cdn_s3.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.cdn_s3.arn
}

output "s3_bucket_regional_domain_name" {
  value = aws_s3_bucket.cdn_s3.bucket_regional_domain_name
}
