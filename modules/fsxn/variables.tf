variable "project_prefix" {
  description = "Name of the Project prefix"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "fsx_admin_password" {
  description = "Admin password"
  type        = string
}
