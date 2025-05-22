
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = {
    Name = "${each.key}_Public_Subnet"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = var.vpc_id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = each.key
  tags = {
    Name = "${each.key}_Private_Subnet"
  }
}

resource "aws_internet_gateway" "CP_IGW" {
  vpc_id = var.vpc_id
  tags = {
    Name = "CP_IGW"
  }
}

resource "aws_route_table" "public" {
  depends_on = [aws_internet_gateway.CP_IGW]
  vpc_id     = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.CP_IGW.id
  }
  tags = {
    "name" = "publicRT"
  }
}

# resource "aws_route_table" "private" {
#   depends_on = [aws_internet_gateway.CP_IGW]
#   vpc_id     = var.vpc_id
#   tags = {
#     "name" = "privateRT"
#   }
# }

resource "aws_route_table_association" "public_assoc" {
  route_table_id = aws_route_table.public.id
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
}

# resource "aws_route_table_association" "private_assoc" {
#   route_table_id = aws_route_table.private.id
#   for_each       = aws_subnet.private_subnets
#   subnet_id      = each.value.id
# }

resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.CP_IGW]
  domain     = "vpc"
  tags = {
    "name" = "EIP_IGW"
  }
}

resource "aws_nat_gateway" "NGW" {
  allocation_id = aws_eip.eip.id
  # for_each  = aws_subnet.public_subnets
  # subnet_id = each.value.id
  subnet_id = aws_subnet.public_subnets["us-east-1a"].id

  tags = {
    Name = "gwNAT"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.CP_IGW]
}

resource "aws_route_table" "private" {
  depends_on = [aws_internet_gateway.CP_IGW]
  vpc_id     = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NGW.id
  }
  tags = {
    "name" = "privateRT"
  }
}


resource "aws_route_table_association" "private_assoc" {
  route_table_id = aws_route_table.private.id
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
}
