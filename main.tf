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
 
    lifecycle_rule {
      enabled = true
    }
 
    tags = {
      Name = "S3 Remote Terraform State Store"
    }      
}

resource "aws_s3_bucket_policy" "buildat-state-policy" {
  bucket = "buildat-state-storage"

  policy = <<POLICY
{
  "Id": "Policy1591731231798",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1591731226539",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::buildat-state-storage",
      "Principal": {
        "AWS": [
          "arn:aws:iam::011408120377:user/*"
        ]
      }
    }
  ]
}
POLICY
}