# Genesys Cloud CX as Code - Test Repository

This repository manages Genesys Cloud test users using Terraform and GitHub Actions.

## Repository structure

```text
genesys-cloud-cx-as-code-test/
|-- .github/
|   |-- workflows/
|   |   `-- terraform.yml
|   |-- CODEOWNERS
|   `-- pull_request_template.md
|-- environments/
|   `-- test/
|       `-- test.tfvars
|-- tests/
|   `-- users.tftest.hcl
|-- backend.tf
|-- outputs.tf
|-- provider.tf
|-- users.tf
|-- variables.tf
|-- versions.tf
|-- .gitignore
`-- README.md
```

## Pipeline behavior

### Pull request to main

The workflow automatically runs formatting, initialization without the remote backend, validation and mocked Terraform tests. It does not plan against the live test organization and does not apply changes.

### Merge or push to main

There is no `push` trigger. Merging or pushing to `main` does not start the workflow.

### Manual test plan

Open **Actions**, select **Genesys Cloud CX as Code - Test**, choose **Run workflow**, select the `main` branch and choose `plan`.

### Manual test deployment

Run the same workflow from `main` and choose `apply`. The workflow validates the code, creates a saved plan, pauses at the protected GitHub Environment named `test`, and applies the saved plan only after approval.

## GitHub repository configuration

Create these secrets:

```text
GENESYSCLOUD_OAUTHCLIENT_ID
GENESYSCLOUD_OAUTHCLIENT_SECRET
AWS_ROLE_TO_ASSUME
```

Create these variables:

```text
AWS_REGION
GENESYSCLOUD_REGION
```

Create a GitHub Environment named `test` and configure required reviewers. Restrict it to the `main` branch and prevent self-review where supported.

Protect the `main` branch. Require pull requests, approvals, successful status checks and conversation resolution. Block force pushes and direct pushes.

## Required updates before first run

1. Replace the bucket, key and region in `backend.tf` with the approved AWS backend values.
2. Replace the sample user in `environments/test/test.tfvars` with an approved test user.
3. Replace the placeholder teams in `.github/CODEOWNERS`.
4. Configure all GitHub secrets and variables.
5. Create and protect the `test` GitHub Environment.
6. Confirm that the Genesys OAuth role has only the permissions needed to manage the configured resources.

## Local validation

```bash
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
terraform test -no-color
```

For a live local plan, authenticate to AWS for the S3 backend and export the Genesys credentials without writing them into a file:

```bash
export TF_VAR_genesyscloud_oauthclient_id="<CLIENT_ID>"
export TF_VAR_genesyscloud_oauthclient_secret="<CLIENT_SECRET>"
export TF_VAR_genesyscloud_region="ap-south-1"

terraform init -input=false
terraform plan -input=false -var-file=environments/test/test.tfvars
```

## Security safeguards

- Never commit OAuth credentials, Terraform state or saved plan files.
- Review the plan before selecting or approving `apply`.
- Use GitHub OIDC for AWS instead of long-lived AWS access keys.
- Use a separate state path, OAuth client and protected environment for later non-test environments.
