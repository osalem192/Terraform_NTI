provider "aws" {
  region = var.region
}

module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr
}

module "subnets" {
  source          = "./subnet"
  vpc_id          = module.vpc.vpc_id
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

}

module "security_groups" {
  source        = "./sg"
  vpc_id        = module.vpc.vpc_id
  allowed_ports = var.allowed_ports
}

module "ec2" {
  source               = "./ec2"
  ami_ec2              = var.ami_ec2
  private_alb_dns_name = module.alb.private_alb_dns_name
  web_sg_id            = module.security_groups.web_sg_id
  public_subnets       = module.subnets.public_subnet_ids
  private_subnets      = module.subnets.private_subnet_ids
}


module "alb" {
  source               = "./alb"
  vpc_id               = module.vpc.vpc_id
  public_subnets       = module.subnets.public_subnet_ids
  private_subnets      = module.subnets.private_subnet_ids
  alb_sg_id            = module.security_groups.alb_sg_id
  web_sg_id            = module.security_groups.web_sg_id
  public_instance_ids  = module.ec2.public_instance_ids
  private_instance_ids = module.ec2.private_instance_ids
}

