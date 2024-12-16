# Define input variables for reuse and maintainability
variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-west-2"
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true # Mark as sensitive to avoid output in logs
}
