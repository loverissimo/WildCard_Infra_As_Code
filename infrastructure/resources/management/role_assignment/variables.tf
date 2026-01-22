variable "scope" {
  description = "The scope at which the Role Assignment applies to."
  type        = string
}

variable "principal_id" {
  description = "The ID of the Principal (User, Group, or Service Principal) to assign the Role Definition to."
  type        = string
}

variable "role_assignment_optional" {
  description = "Optional configurations for RBAC."
  type = object({
    name                                   = optional(string)
    role_definition_id                     = optional(string)
    role_definition_name                   = optional(string)
    condition                              = optional(string)
    condition_version                      = optional(string) # Possible values are 1.0 or 2.0
    delegated_managed_identity_resource_id = optional(string)
    description                            = optional(string)
    skip_service_principal_aad_check       = optional(bool)
  })
}
