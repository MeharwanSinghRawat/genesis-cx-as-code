resource "genesyscloud_user" "this" {
  for_each = var.users

  name        = each.value.name
  email       = lower(each.value.email)
  division_id = data.genesyscloud_auth_division.devone.id
  title       = try(each.value.title, null)
  department  = try(each.value.department, null)
}
