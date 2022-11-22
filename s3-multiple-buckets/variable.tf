variable "s3_bucket-names" {
  type = list
  default = ["qa-terraform-testing", 
             "dev-terraform-testing", 
             "prod-terraform-teting" 
            ]
}