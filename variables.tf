variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = {
    "us-east-1a" = 0
    "us-east-1b" = 2
  }
}

variable "private_subnets" {
  default = {
    "us-east-1a" = 1
    "us-east-1b" = 3
  }
}

variable "allowed_ports" {
  default = {
    "SSH"   = 22
    "HTTP"  = 80
    "HTTPS" = 443
  }
}

variable "ami_ec2" {
  default = "ami-0953476d60561c955" #amazon linux 2023 
}
