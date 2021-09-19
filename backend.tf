terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "backend-test-terraform-tfstate-backend"
    #key            = "aws-backup/terraform.tfstate"
    region         = "eu-west-1"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "backend-test-terraform-tfstate-backend-lock"
    encrypt        = true
  }
}
