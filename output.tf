output "public_alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.public_alb_dns_name
}

output "private_alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.private_alb_dns_name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Map of public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of private subnet IDs"
  value       = module.subnets.private_subnet_ids
}
