terraform {
  required_version = ">= 1.8.0, < 2.0.0"

  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.84"
    }
  }
}

provider "genesyscloud" {
  oauthclient_id     = var.genesyscloud_oauthclient_id
  oauthclient_secret = var.genesyscloud_oauthclient_secret
  aws_region         = var.genesyscloud_region
}
