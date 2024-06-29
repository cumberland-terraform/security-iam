terraform {
  required_version          = ">= 1.5.0"

  required_providers {
    aws                     = {
      source                = "hashicorp/aws"
      version               = ">= 4.8.0"
      configuration_aliases = [ aws.core ]
    }
    kubernetes              = {
      source                = "hashicorp/kubernetes"
      version               = "2.31.0"
    }
    tls                     = {
      source                = "hashicorp/tls"
      version               = "4.0.5"
    }
  }
}