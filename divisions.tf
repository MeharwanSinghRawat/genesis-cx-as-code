# Retrieves the existing "Devone" division from Genesys Cloud.
# The returned division ID is used when creating users so that they are
# provisioned in the same division where the OAuth client role has access.
data "genesyscloud_auth_division" "devone" {
  name = "Devone"
}