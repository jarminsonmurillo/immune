terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket  = "immune-g2-s3-01"
    key     = "terraform/state/production/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # profile = "default"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
  default_tags {
    tags = var.tags
  }
}

variable "tags" {
  default = {
    Region        = "us-east-1"
    CostCenter    = "Tech"
    ComplianceReq = "True"
    Environment   = "Testing"
  }
}

locals {
  resource_name = "immune-g2"
}

# Removed resource definitions to keep backend.tf focused on backend configuration.