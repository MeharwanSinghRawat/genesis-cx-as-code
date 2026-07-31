output "managed_user_ids" {
  description = "Map of stable Terraform user keys to the corresponding Genesys Cloud user IDs."
  value = {
    for user_key, user in genesyscloud_user.this : user_key => user.id
  }
}

output "managed_user_emails" {
  description = "Sorted list of email addresses for users managed by this Terraform configuration."
  value       = sort([for user in genesyscloud_user.this : user.email])
}

output "managed_user_count" {
  description = "Total number of Genesys Cloud users managed by this Terraform configuration."
  value       = length(genesyscloud_user.this)
}
