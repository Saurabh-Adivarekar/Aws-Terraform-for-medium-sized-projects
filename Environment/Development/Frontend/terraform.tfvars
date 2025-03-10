#Cloudfront and s3

region = "ap-south-1"

tags = {
  "Infra" = "template_dev_infra"
}

s3_bucket_name = "template-dev-cdn-s3"

s3_cors_rule = [
  {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
]

cloudfront_default_cache_behavior = [
  {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    viewer_protocol_policy = "redirect-to-https"
  }
]

cloudfront_custom_error_response = [
  {
    error_code         = "403"
    response_code      = "200"
    response_page_path = "/index.html"
  },
  {
    error_code         = "404"
    response_code      = "200"
    response_page_path = "/index.html"
  }
]

cloudfront_s3_origin_name = "template-dev-cdn-s3-oac"

