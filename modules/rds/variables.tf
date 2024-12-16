variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "private_subnets" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for RDS"
  type        = string
}
