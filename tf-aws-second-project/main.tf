module "data_bucket" {
  source = "../tf-aws-playground/modules/s3-bucket"

  bucket_name = "myapp2-dev-data"
  environment = "dev"
  extra_tags  = { Team = "platform" }
}
