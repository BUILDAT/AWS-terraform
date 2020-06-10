terraform {
  backend "s3" {
    bucket = "buildat-state-storage"
    key    = "terraform.tfstate"
    region = "us-west-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "buildat-terraform-locks"
    encrypt        = true
  }
}