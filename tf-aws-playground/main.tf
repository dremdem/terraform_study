terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }    
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  for_each = { 
    for name, val in
    var.buckets:
    name => val
    if lookup(var.bucket_filter, name, false)
  }

  bucket = "${lookup(var.bucket_prefixes, each.key, "null-prefix")}-${each.value.bucket_name}-${random_id.bucket_suffix.hex}"
  tags   = each.value.tags
}

resource "random_pet" "example" {
  count  = var.pet_count
  length = 2
}

