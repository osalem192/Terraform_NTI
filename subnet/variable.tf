variable "vpc_id" { type = string }

variable "vpc_cidr" { type = string }

variable "public_subnets" { type = map(number) }

variable "private_subnets" { type = map(number) }

