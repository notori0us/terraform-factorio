terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {
      hostname = "app.terraform.io"
      organization = "notori0us"

      workspaces {
          name = "terraform-factorio"
      }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_key
}

data "aws_region" "current" {}
