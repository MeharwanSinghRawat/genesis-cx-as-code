terraform {
  backend "s3" {
    bucket       = "genesys-cloud-terraform-state-test"
    key          = "genesys-cloud/test/users/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
