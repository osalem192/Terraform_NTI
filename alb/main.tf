resource "aws_lb" "public_alb" {
  depends_on         = [var.vpc_id]
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnets["us-east-1a"], var.public_subnets["us-east-1b"]]
}

resource "aws_lb_target_group" "public_alb_tg" {
  name     = "public-alb"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    "name" = "ALB_TG"
  }
}

resource "aws_lb_target_group_attachment" "public_alb_tg_attach" {
  target_group_arn = aws_lb_target_group.public_alb_tg.arn
  for_each         = var.public_instance_ids
  target_id        = each.value
  port             = "80"
}

resource "aws_lb_listener" "public_alb_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_alb_tg.arn
  }
}

resource "aws_lb" "private_alb" {
  depends_on         = [var.vpc_id]
  name               = "private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.private_subnets["us-east-1a"], var.private_subnets["us-east-1b"]]
}

resource "aws_lb_target_group" "private_alb_tg" {
  name     = "private-alb-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    "name" = "private-ALB_TG"
  }
}

resource "aws_lb_target_group_attachment" "private_alb_tg_attach" {
  target_group_arn = aws_lb_target_group.private_alb_tg.arn
  for_each         = var.private_instance_ids
  target_id        = each.value
  port             = "80"
}

resource "aws_lb_listener" "private_alb_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_alb_tg.arn
  }
}
