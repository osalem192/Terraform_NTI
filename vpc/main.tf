resource "aws_vpc" "custom" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Custom_Project_VPC"
  }
}
