# Genesys Cloud Test CX as Code

## Deployment flow

- Pull requests to `main` automatically run format, initialization, validation, native tests and plan only.
- Merging or pushing to `main` does not trigger this workflow.
- Deployment starts only when an authorized user manually selects **Run workflow** on the `main` branch.
- The manual run creates a saved plan, then the protected `test` environment requires approval before apply.

## GitHub configuration

Repository secrets:

- `GENESYSCLOUD_OAUTHCLIENT_ID`
- `GENESYSCLOUD_OAUTHCLIENT_SECRET`
- `AWS_ROLE_TO_ASSUME`

Repository variables:

- `AWS_REGION`
- `GENESYSCLOUD_REGION`

Before deployment, update `backend.tf`, `test.tfvars`, and `.github/CODEOWNERS`. Create the protected GitHub Environment named `test` and assign required reviewers.

## Terraform file structure

- `backend.tf`: S3 remote-state and native lock-file configuration.
- `provider.tf`: Terraform and Genesys Cloud provider requirements.
- `variables.tf`: Input variables, descriptions, types, sensitivity and validations.
- `users.tf`: Genesys Cloud user resources.
- `outputs.tf`: Managed user IDs, email addresses and count.
- `test.tfvars`: Non-secret test-environment input values.
- `tests/users_policy.tftest.hcl`: Native Terraform tests using a mocked Genesys Cloud provider.
