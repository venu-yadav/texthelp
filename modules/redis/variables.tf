variable "private_subnets" {
  description = "Private subnets for Redis"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for Redis"
  type        = string
}
