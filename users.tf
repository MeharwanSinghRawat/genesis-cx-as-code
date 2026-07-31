resource "genesyscloud_user" "users" {
  for_each = var.users

  name       = each.value.name
  email      = each.value.email
  title      = try(each.value.title, null)
  department = try(each.value.department, null)
}
