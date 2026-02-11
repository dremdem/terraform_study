# output "bucket_arn" {
#   description = "ARN of the S3 bucket"
#   value       = aws_s3_bucket.this["dev"].arn
# }

output "pet_names" {
  description = "Generated pet names"
  value       = random_pet.example[*].id
}

output "second_az" {
  value = var.availability_zones[1]
}

output "counts_dev" {
  value = lookup(var.counts_per_env, "dev", 0)
}

