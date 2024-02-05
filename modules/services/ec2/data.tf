

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-*-x86_64"] # Replace with the actual naming pattern for Amazon Linux 2023 AMI
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}
