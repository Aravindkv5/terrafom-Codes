resource "aws_s3_bucket" "cloudfront-s3" {
  bucket = "cloudfront-bucket-new-terraform"
  website {
    index_document = "index.html"
  }


  tags = {
    Name        = "My bucket"
    Environment = "QA"
  }

  
}


resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.cloudfront-s3.id
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "terraform-bucket" {
    bucket = aws_s3_bucket.cloudfront-s3.id
    content = file("index.html")
    key = "myfirstterraformbucket/index.html"
    acl    = "public-read" //Error: expected acl to be one of [private public-read public-read-write authenticated-read aws-exec-read bucket-owner-read bucket-owner-full-control], got private public-read
    
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = file("index.html")
}


resource "aws_s3_bucket_object" "aws-image" {
    bucket = aws_s3_bucket.cloudfront-s3.id
    content = filemd5("aws.jpg")
    key = "myfirstterraformbucket/aws.jpg"
    acl    = "public-read" //Error: expected acl to be one of [private public-read public-read-write 
}

