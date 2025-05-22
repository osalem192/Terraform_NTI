resource "aws_security_group" "webSG" {
  vpc_id = var.vpc_id
  tags = {
    Name = "webSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allowed_web_in_ports" {
  for_each          = var.allowed_ports
  security_group_id = aws_security_group.webSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value
  tags = {
    "name" = "${each.key}_port_ingress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allowed_web_eg_ports" {
  for_each          = var.allowed_ports
  security_group_id = aws_security_group.webSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value
  tags = {
    "name" = "${each.key}_port_egress"
  }
}

resource "aws_security_group" "ALBSG" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ALBSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allowed_albsg_in_ports" {
  security_group_id = aws_security_group.ALBSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  tags = {
    "name" = "HTTP_port_ingress"
  }
}

resource "aws_vpc_security_group_egress_rule" "allowed_albsg_eg_ports" {
  security_group_id = aws_security_group.ALBSG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  tags = {
    "name" = "HTTP_port_egress"
  }
}


resource "aws_security_group" "private_ALBSG" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ALBSG"
  }
}

# resource "aws_vpc_security_group_ingress_rule" "allowed_private_albsg_in_ports" {
#   security_group_id = aws_security_group.ALBSG.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
#   tags = {
#     "name" = "HTTP_port_ingress"
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "allowed_albsg_eg_ports" {
#   security_group_id = aws_security_group.ALBSG.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
#   tags = {
#     "name" = "HTTP_port_egress"
#   }
# }

