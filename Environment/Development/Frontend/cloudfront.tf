## CloudFront module

module "cloudfront" {
  source = "../../../Module/cloudfront"

  aliases                = var.cloudfront_aliases
  default_cache_behavior = var.cloudfront_default_cache_behavior
  custom_error_response  = var.cloudfront_custom_error_response
  s3_origin_name         = var.cloudfront_s3_origin_name

  origin = {
    domain_name = module.s3.s3_bucket_regional_domain_name
    origin_id   = module.s3.s3_bucket_regional_domain_name
  }

  tags = var.tags
}