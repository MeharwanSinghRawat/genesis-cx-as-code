variable "genesyscloud_oauthclient_id" {
  description = "Client ID of the dedicated Genesys Cloud OAuth client configured with the Client Credentials grant."
  type        = string
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(trimspace(var.genesyscloud_oauthclient_id)) > 0
    error_message = "genesyscloud_oauthclient_id must not be empty."
  }
}

variable "genesyscloud_oauthclient_secret" {
  description = "Client secret of the dedicated Genesys Cloud OAuth client. Provide it through a protected GitHub secret."
  type        = string
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(trimspace(var.genesyscloud_oauthclient_secret)) > 0
    error_message = "genesyscloud_oauthclient_secret must not be empty."
  }
}

variable "genesyscloud_region" {
  description = "AWS region identifier used by the target Genesys Cloud organization, for example ap-south-1."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[a-z]{2}(-gov)?-[a-z]+-[0-9]+$", var.genesyscloud_region))
    error_message = "genesyscloud_region must be a valid region identifier such as ap-south-1."
  }
}

variable "users" {
  description = "Map of test users managed in Genesys Cloud. Each map key must remain stable because Terraform uses it as the resource instance key."
  type = map(object({
    name       = string
    email      = string
    title      = optional(string)
    department = optional(string)
  }))
  nullable = false

  validation {
    condition     = length(var.users) > 0
    error_message = "At least one test user must be defined."
  }

  validation {
    condition = alltrue([
      for user in values(var.users) : length(trimspace(user.name)) > 0
    ])
    error_message = "Every user must have a non-empty name."
  }

  validation {
    condition = alltrue([
      for user in values(var.users) : can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", user.email))
    ])
    error_message = "Every user must have a valid email address."
  }
}
