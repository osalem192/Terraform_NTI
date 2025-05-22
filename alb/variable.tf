variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}

variable "alb_sg_id" {
  type = string
}

variable "web_sg_id" {
  type = string
}

variable "public_instance_ids" {
  type = map(string)
}

variable "private_instance_ids" {
  type = map(string)
}
