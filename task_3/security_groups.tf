###############################################################################
# Security Groups
###############################################################################

# Bastion Host SG
resource "aws_security_group" "bastion_sg" {
  name        = "task3-bastion-sg"
  description = "Allow SSH and Kubernetes API (6443) to the bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["82.215.116.67/32"]
  }

  ingress {
    description = "k3s API from anywhere"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "task3-bastion-sg"
  }
}

# Worker Nodes SG
resource "aws_security_group" "node_sg" {
  name        = "task3-worker-sg"
  description = "Allow SSH and k3s traffic from bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "SSH from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description     = "k3s API traffic from bastion"
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "Node-to-node communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "task3-worker-sg"
  }
}