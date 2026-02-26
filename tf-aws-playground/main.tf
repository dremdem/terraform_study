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

resource "null_resource" "debug" {
  provisioner "local-exec" {
    command = "echo ${local.all_of_them}"
  }
}

module "data_bucket" {
  source = "./modules/s3-bucket"

  bucket_name = "myapp1-dev-data"
  environment = "dev"
  extra_tags  = { Team = "platform" }
}

module "logs_bucket" {
  source = "./modules/s3-bucket"

  bucket_name = "myapp1-dev-logs"
  environment = "dev"
  extra_tags  = { Purpose = "logging" }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}

