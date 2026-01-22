variable "name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the Azure Resource Group"
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
}

variable "acr_optional" {
  description = "Optional configuration for Azure Container Registry"
  type = object({
    admin_enabled                 = optional(bool)
    public_network_access_enabled = optional(bool)
    quarantine_policy_enabled     = optional(bool)
    zone_redundancy_enabled       = optional(bool)
    export_policy_enabled         = optional(bool)
    anonymous_pull_enabled        = optional(bool)
    data_endpoint_enabled         = optional(bool)
    network_rule_bypass_option    = optional(string)
    tags                          = optional(map(string))
  })
}

variable "acr_optional_block" {
  description = "Optional blocks for Azure Container Registry"
  type = object({
    georeplications = optional(object({
      location                  = string
      regional_endpoint_enabled = optional(bool)
      zone_redundancy_enabled   = optional(bool)
      tags                      = optional(map(string))
    }), null)
    /* network_rule_set = object({ #NOTE - it is only supported with the Premium SKU
      default_action = optional(string)
      ip_rule = optional(list(object({
        action   = string
        ip_range = string
      })))
      virtual_network = optional(list(object({
        action    = string
        subnet_id = string
      })))
    }) */
    retention_policy = optional(object({
      days    = optional(number)
      enabled = optional(bool)
    }))
    trust_policy = optional(object({
      enabled = optional(bool)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }), null)
    encryption = optional(object({
      enabled            = optional(bool)
      key_vault_key_id   = string
      identity_client_id = string
    }), null)
  })
}
