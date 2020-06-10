terraform {
  backend "s3" {
    bucket = "buildat-state-storage"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}