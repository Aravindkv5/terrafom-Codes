resource "aws_s3_bucket" "multiple-buckets" {
  count         = length(var.s3_bucket-names) //count will be 3
  bucket        = var.s3_bucket-names[count.index]
  acl           = "private"
  force_destroy = true
}