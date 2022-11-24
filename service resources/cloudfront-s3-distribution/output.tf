output domain_name {
  value = aws_cloudfront_distribution.tf.domain_name
}

output hosted_zone_id {
  value = aws_cloudfront_distribution.tf.hosted_zone_id
}