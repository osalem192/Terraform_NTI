
output "public_subnet_ids" {
  value = { for k, v in aws_subnet.public_subnets : k => v.id }
}

output "private_subnet_ids" {
  value = { for k, v in aws_subnet.private_subnets : k => v.id }
}
