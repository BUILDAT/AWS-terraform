provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/Users/drew/.aws"
  profile                 = "default"
}

# resource "aws_instance" "example" {
#  ami           = "ami-2757f631"
#  instance_type = "t2.micro"
# }

# VPC
resource "aws_vpc" "AndrewVPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "AndrewVPC"
  }
}

# Create an S3 bucket
resource "aws_s3_bucket" "buildat-state-storage" {
    bucket = "buildat-state-storage"
 
    versioning {
      enabled = true
    }
 
    tags = {
      Name = "S3 Remote Terraform State Store"
    }      
}
# Create a DynamoDB 
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "buildat-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}