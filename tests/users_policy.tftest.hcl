mock_provider "genesyscloud" {}

run "validate_test_user_policy" {
  command = plan

  variables {
    genesyscloud_oauthclient_id     = "mock-client-id"
    genesyscloud_oauthclient_secret = "mock-client-secret"
    genesyscloud_region             = "ap-south-1"

    users = {
      test_user_001 = {
        name       = "Test User One"
        email      = "test.user.one@example.com"
        title      = "Test Agent"
        department = "Cloud Operations"
      }
    }
  }

  assert {
    condition     = length(var.users) > 0
    error_message = "At least one user must be configured."
  }

  assert {
    condition = alltrue([
      for user in values(var.users) : length(trimspace(user.name)) > 0
    ])
    error_message = "Every user must have a non-empty name."
  }

  assert {
    condition = alltrue([
      for user in values(var.users) : can(regex("^[^@\s]+@[^@\s]+\.[^@\s]+$", user.email))
    ])
    error_message = "Every user must have a valid email address."
  }
}
