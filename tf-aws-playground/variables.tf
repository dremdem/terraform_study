variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
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

variable "counts_per_env" {
  type = map(number)
  default = {
    dev = 1
    staging = 2
    prod = 3
  }
}

variable "buckets" {
    type = map(object({
        bucket_name = string
        tags = map(string)
    }))
    default = {
        dev = {
            bucket_name = "my-dev-bucket"
            tags = {
                name1 = "develop"
                name2 = "think"
            }
        }
        prod = {
            bucket_name = "my-prod-bucket"
            tags = {
                name1 = "execuute"
                name2 = "use"
            }
        }
    }
}