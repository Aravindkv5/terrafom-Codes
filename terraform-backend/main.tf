terraform {
  backend "s3" {
    bucket = "Bucket-name"
    key = "path"
    region = "region"
    dynamodb_table = "dynaodb-name"
  }
}
