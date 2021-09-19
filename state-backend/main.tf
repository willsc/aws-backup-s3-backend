provider "aws" {
  region = var.region
}

module "tfstate_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "0.37.0"

  force_destroy = true

  bucket_enabled   = var.bucket_enabled
  dynamodb_enabled = var.dynamodb_enabled

  context = module.this.context
}

