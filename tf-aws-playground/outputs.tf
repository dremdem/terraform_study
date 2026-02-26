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

output "data_bucket_arn" {
  value = module.data_bucket.bucket_arn
}

output "logs_bucket_arn" {
  value = module.logs_bucket.bucket_arn
}

# Use a module output as input to another resource
resource "aws_iam_policy" "bucket_access" {
  name = "bucket-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "${module.data_bucket.bucket_arn}/*"
      }
    ]
  })
}