output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "worker_private_ips" {
  value = [for instance in aws_instance.worker : instance.private_ip]
}