resource "aws_s3_bucket" "myfirstterraformbucket" { 
    bucket = "new-s3-bucket-terraform"  #this is the s3 bucket name
    tags = { 
        Description = "My first S3 Bucket through Terraform"
    
    }
  
}

resource "aws_s3_bucket_object" "terraform-bucket" {
    content = "/root/myfirstterraformbucket.doc"
    key = "myfirstterraformbucket.doc"
    bucket = aws_s3_bucket.myfirstterraformbucket.bucket
  
}

#resource "aws_s3_bucket_policy" "terraform-bucket-policy" {
    #bucket = aws_s3_bucket.myfirstterraformbucket.id
    //#policy = "//file(policy.json)"
  
#}
#tags not working it thorws some error, syeso removed in cmd
