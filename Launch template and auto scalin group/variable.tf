variable "ami" {
    default = "ami-0e6329e222e662a52" #Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type  (64-bit (x86))
    type = string
    description = "Selects the above ami as default"
}

variable "instance_type" {
    default = "t2.micro"
    type = string
    description = "Selects the type of machine"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  default     = "AK_1"
}

variable "instance_count" {
    default = ["1","2","3","4"]
    description = "This gives the no of instances to be created"
  
}
variable "iam_instance_profile" {
    default = ["ec2-ssm-role"]
    description = "we can assign the IAM role needed to the EC2 instances"
  
}

variable "security_groups" {
    default = ["sg-06dd2b8a3d91a6aa2"]
  
}

variable "associate_public_ip_address" {
    default = true
    type = bool #For Bool we need to give either true or false 
    description = "This tells us to assign public ip or not"
 
}

variable "availability_zone" {
    default = "ap-south-1b" #For Bool we need to give either true or false
    description = "This assigns the availability zone "
      
}

variable "subnet_id" {
    default = "subnet-061d1445556c2d5ba"
    description = "This provide the suubnet for the instance"
  
}

variable "hibernation" {
    default = false #For hibernation, the root device volume must be encrypted.
    description = "We can enable or disable the hibernation" #For Bool we need to give either true or false 
    type = bool

}


#variable "aws_key_pair_id" {
    #default = "AK_1"
    #type = string
    #description = "Selects the aws keypair"
#}


#need to check on how to provide keypair
