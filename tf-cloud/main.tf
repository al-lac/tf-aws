terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    hcp = {
        source  = "hashicorp/hcp"
        version = "~> 0.60.0"
    }
  }
}

# Configure the  HCP provider
provider "hcp" {}

data "hcp_vault_secrets_app" "aws" {
  app_name = "aws"
}

output "aws" {
  value = data.hcp_vault_secrets_app.hcp_vault_secrets_app.secrets
}

variable "access" {
  type = string
}

variable "secret" {
  type = string
}

# Configure the AWS Provider
provider "aws" {
  region     = "eu-central-1"
  access_key = var.access
  secret_key = var.secret
}
