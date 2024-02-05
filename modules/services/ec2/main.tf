resource "aws_instance" "test" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = local.environment
  }
}