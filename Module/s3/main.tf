## S3 Bucket
resource "aws_s3_bucket" "cdn_s3" {
  bucket = var.bucket_name
  force_destroy = true
  tags = var.tags
}

## S3 Bucket CORS
resource "aws_s3_bucket_cors_configuration" "cdn_s3_cors" {
  bucket = aws_s3_bucket.cdn_s3.id

  dynamic "cors_rule" {
    for_each = var.cors_rule

    content {
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      allowed_methods = try(cors_rule.value.allowed_methods, null)
      allowed_origins = try(cors_rule.value.allowed_origins, null)
      expose_headers  = try(cors_rule.value.expose_headers, null)
      id              = try(cors_rule.value.id, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
    }
  }
}

## S3 Bucket Policy
resource "aws_s3_bucket_policy" "cdn_s3_policy" {
  bucket = aws_s3_bucket.cdn_s3.id

  policy = var.bucket_policy
}