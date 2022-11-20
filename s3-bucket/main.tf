resource "aws_s3_bucket" "myfirstterraformbucket" { 
    bucket = "new-s3-bucket-terraform"  #this is the s3 bucket name
    tags = { 
        Description = "My first S3 Bucket through Terraform"
    
    }
  
}

#Below will create the s3 bucket folder and index.html file will be there in it. 

resource "aws_s3_bucket_object" "terraform-bucket" {
    content = file("index.html")
    key = "myfirstterraformbucket/index.html"
    bucket = aws_s3_bucket.myfirstterraformbucket.bucket
    acl = null 
  
}


# resource "aws_s3_bucket_object" "terraform-bucket" {
#     content = "/root/myfirstterraformbucket.doc"
#     key = "myfirstterraformbucket.doc"
#     bucket = aws_s3_bucket.myfirstterraformbucket.bucket
  
# }

#resource "aws_s3_bucket_policy" "terraform-bucket-policy" {
    #bucket = aws_s3_bucket.myfirstterraformbucket.id
    //#policy = "//file(policy.json)"
  
#}
#tags not working it thorws some error, syeso removed in cmd
