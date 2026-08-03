terraform {
  backend "s3" {
    bucket       = "genesys-cx-terraform-state-687259232475"
    key          = "genesys-cloud/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
