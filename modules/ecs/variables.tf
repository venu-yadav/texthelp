variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets for ECS tasks"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for ECS"
  type        = string
}
