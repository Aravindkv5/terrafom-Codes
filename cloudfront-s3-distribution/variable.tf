variable region {}
variable domain_name {
    default = "cloudfront-bucket-new-terraform.s3.ap-south-1.amazonaws.com"
   
}
variable origin_id { default = "" }

variable s3_endpoint { default = "" }

variable "bucket-region" {
  default = "ap-south-1"
}

variable "domain-name" {
  default = "amazon.com"
}