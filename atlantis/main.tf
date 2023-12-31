terraform {
  backend "s3" {
    bucket = "tf-controller-alex-bucket"
    key    = "atlantis"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "eu-central-1"
}
