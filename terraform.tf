terraform {
  required_version          = ">= 1.5.0"

  required_providers {
    aws                     = {
      source                = "hashicorp/aws"
      version               = ">= 4.8.0"
    }
    kubernetes              = {
      source                = "hashicorp/kubernetes"
      version               = "2.31.0"
    }
  }
}