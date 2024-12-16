provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "webapp-vpc"
  cidr   = "10.0.0.0/16"
  azs    = ["us-west-2a", "us-west-2b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_flow_logs     = true
}

# ECS Cluster and Service
module "ecs" {
  source         = "./modules/ecs"
  cluster_name   = "webapp-ecs-cluster"
  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

# Redis Cache
module "redis" {
  source          = "./modules/redis"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

# RDS MySQL Database
module "rds" {
  source          = "./modules/rds"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  db_name         = "webapp_db"
  username        = "admin"
  password        = var.db_password
}
