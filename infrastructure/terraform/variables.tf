variable "aws_region" {
  description = "AWS region for SK BazaarHub"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  type    = string
  default = "sk-bazaarhub"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "db_name" {
  type    = string
  default = "bazaarhub"
}

variable "db_username" {
  type    = string
  default = "bazaar_app"
}

variable "db_password" {
  description = "Supply securely through TF_VAR_db_password or a secrets workflow. Never commit it."
  type        = string
  sensitive   = true
}

variable "allowed_admin_cidr" {
  description = "Your trusted public IP in CIDR notation, e.g. 203.0.113.10/32. Do not use 0.0.0.0/0."
  type        = string
}
