###############################################################################
# Worker Nodes
###############################################################################

resource "aws_instance" "worker" {
  count = 2
  ami   = "ami-000ec6c25978d5999"

  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnets[count.index]
  key_name      = var.key_pair_name

  # Reference the worker-node security group defined in security_groups.tf
  vpc_security_group_ids = [
    aws_security_group.node_sg.id
  ]

  # Join the k3s cluster via your worker install script
  user_data = file("${path.module}/install_worker.sh")

  tags = {
    Name = "task3-worker-${count.index}"
  }
}
