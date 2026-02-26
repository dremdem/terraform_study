# backend.tf (in your root module)

# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state-bucket-raider123"
#     key            = "tf-aws-playground/terraform.tfstate"
#     region         = "ap-southeast-1"
#     use_lockfile   = true
#     encrypt        = true
#   }
# }

terraform {
  cloud {

    organization = "dremdem"

    workspaces {
      name = "test1"
    }
  }
}
