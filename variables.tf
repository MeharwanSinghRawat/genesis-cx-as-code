variable "genesyscloud_oauthclient_id" {
  description = "Client ID of the dedicated Genesys Cloud OAuth client that uses the Client Credentials grant."
  type        = string
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(trimspace(var.genesyscloud_oauthclient_id)) > 0
    error_message = "genesyscloud_oauthclient_id must not be empty."
  }
}

variable "genesyscloud_oauthclient_secret" {
  description = "Client secret of the dedicated Genesys Cloud OAuth client. Supply this value securely through GitHub Actions."
  type        = string
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(trimspace(var.genesyscloud_oauthclient_secret)) > 0
    error_message = "genesyscloud_oauthclient_secret must not be empty."
  }
}

variable "genesyscloud_region" {
  description = "AWS region code associated with the target Genesys Cloud organization, for example ap-south-1."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.genesyscloud_region)) > 0
    error_message = "genesyscloud_region must not be empty."
  }
}

variable "users" {
  description = "Map of Genesys Cloud users to create or manage. The map key is a stable Terraform identifier for each user."
  type = map(object({
    name       = string
    email      = string
    title      = optional(string)
    department = optional(string)
  }))
  nullable = false

  validation {
    condition     = length(var.users) > 0
    error_message = "At least one user must be defined."
  }

  validation {
    condition = alltrue([
      for user in values(var.users) : length(trimspace(user.name)) > 0
    ])
    error_message = "Every user must have a non-empty name."
  }

  validation {
    condition = alltrue([
      for user in values(var.users) : can(regex("^[^@\s]+@[^@\s]+\.[^@\s]+$", user.email))
    ])
    error_message = "Every user must have a valid email address."
  }
}
