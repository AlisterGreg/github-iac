terraform {
  required_version = ">= 1.15"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "github-iac-terraform-state"
    key    = "github-iac/terraform.tfstate"
    region = "eu-west-1"
  }
}
