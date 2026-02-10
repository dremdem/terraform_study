output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.example.arn
}

output "pet_names" {
  description = "Generated pet names"
  value       = random_pet.example[*].id
}