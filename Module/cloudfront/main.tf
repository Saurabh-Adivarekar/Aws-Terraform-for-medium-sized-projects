## CloudFront Distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  default_root_object = "/index.html"
  is_ipv6_enabled     = true

  # aliases = var.aliases

  dynamic "default_cache_behavior" {
    for_each = var.default_cache_behavior

    content {
      allowed_methods        = try(default_cache_behavior.value.allowed_methods, null)
      cached_methods         = try(default_cache_behavior.value.cached_methods, null)
      cache_policy_id        = try(default_cache_behavior.value.cache_policy_id, null)
      target_origin_id       = var.origin.origin_id
      viewer_protocol_policy = try(default_cache_behavior.value.viewer_protocol_policy, null)
    }
  }

  origin {
    domain_name              = var.origin.domain_name
    origin_id                = var.origin.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_origin.id
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response

    content {
      error_code            = try(custom_error_response.value.error_code, null)
      response_code         = try(custom_error_response.value.response_code, null)
      response_page_path    = try(custom_error_response.value.response_page_path, null)
      error_caching_min_ttl = "10"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

## CloudFront OAC
resource "aws_cloudfront_origin_access_control" "s3_origin" {
  name                              = var.s3_origin_name
  description                       = "CloudFront S3 Origin"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
