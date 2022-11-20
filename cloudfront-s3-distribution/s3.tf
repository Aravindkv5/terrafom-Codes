resource "aws_s3_bucket" "cloudfront-s3" {
  bucket = "cloudfront-bucket-new-terraform"

  tags = {
    Name        = "My bucket"
    Environment = "QA"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.cloudfront-s3.id
  acl    = "public"
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.cloudfront-s3.bucket
  key    = "index.html"
  content = file("index.html")
  

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = file("index.html")
}