output "public_instance_ids" {
  value = { for k, v in aws_instance.web : k => v.id }
}

output "private_instance_ids" {
  value = { for k, v in aws_instance.private : k => v.id }
}
