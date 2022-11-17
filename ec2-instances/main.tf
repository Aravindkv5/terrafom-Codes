resource "aws_instance" "terraform" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    count = var.instance_count[0]
    iam_instance_profile = var.iam_instance_profile[0]
    security_groups = var.security_groups
    associate_public_ip_address = var.associate_public_ip_address
    availability_zone = var.availability_zone
    hibernation = var.hibernation
    subnet_id = var.subnet_id
    tags = {
        name = "terraform testing" 
    }
    user_data = file("userdata.tpl")
      
}

terraform {
  backend "s3" {
    bucket = "Bucket-name"
    key = "path"
    region = "region"
    dynamodb_table = "dynaodb-name"
  }
}

#name was empty in created ec2 instance and output was instance ID
#need to check on how to provide keypair
