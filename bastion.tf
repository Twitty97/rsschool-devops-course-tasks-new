resource "aws_instance" "bastion" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  key_name      = "your-key-name" # Replace with your actual key

  security_groups = [aws_security_group.public_sg.name]

  tags = {
    Name = "BastionHost"
  }
}