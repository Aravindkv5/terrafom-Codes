resource "aws_instance" "import-terraform" {
 ami           = "unknown"
 instance_type = "unknown"
 key_name = "unknown"
}

resource "aws_s3_bucket" "bucket" {
    bucket = ""
  
}

# resource "aws_cloudfront_distribution" "test" {
#     origin {
#     domain_name = ""
#     origin_id = ""
  
# }
# }