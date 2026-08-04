terraform {
  required_version = ">= 1.10.0, < 2.0.0"

  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.84"
    }
  }
}
