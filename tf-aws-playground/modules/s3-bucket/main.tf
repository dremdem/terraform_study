resource "aws_s3_bucket" "this1" {
  bucket = var.bucket_name

  tags = merge(
    {
      Environment = var.environment
      ManagedBy   = "terraform"
    },
    var.extra_tags
  )
  lifecycle { 
    ignore_changes = [tags["owner"]] 
  }
}