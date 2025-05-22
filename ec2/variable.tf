variable "ami_ec2" {
  type = string
}

variable "web_sg_id" {
  type = string
}

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}

variable "private_alb_dns_name" {
  type = string
}
