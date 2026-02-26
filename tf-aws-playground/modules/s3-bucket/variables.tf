variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "environment" {
  type        = string
  description = "Environment tag (dev, staging, prod)"
  default     = "dev"
}

variable "extra_tags" {
  type        = map(string)
  description = "Additional tags to apply"
  default     = {}
}