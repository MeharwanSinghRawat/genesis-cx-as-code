mock_provider "genesyscloud" {}

run "valid_test_user_configuration" {
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
    condition     = length(var.users) == 1
    error_message = "The test configuration must contain one user in this test case."
  }

  assert {
    condition     = genesyscloud_user.this["test_user_001"].email == "test.user.one@example.com"
    error_message = "The generated Genesys Cloud user email is incorrect."
  }

  assert {
    condition     = output.managed_user_count == 1
    error_message = "The managed user count output is incorrect."
  }
}
