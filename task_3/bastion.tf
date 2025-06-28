resource "aws_instance" "bastion" {
  ami = "ami-000ec6c25978d5999"

  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]

  associate_public_ip_address = true
  key_name                    = var.key_pair_name

  vpc_security_group_ids = [
    aws_security_group.bastion_sg.id
  ]

  user_data = file("${path.module}/install_bastion.sh")

  tags = {
    Name = "bastion-host"
  }
}