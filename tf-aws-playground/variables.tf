variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "pet_count" {
  type        = number
  description = "Number of random pets to create"
  default     = 3
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}