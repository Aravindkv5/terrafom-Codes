data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-*-x86_64"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  #key_name      = var.instance_name  # Use the instance_name as the key name for simplicity

  tags = {
    Name = "chatgpt"
  }
}

output "public_ip" {
  description = "Public IP address of the created EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}
