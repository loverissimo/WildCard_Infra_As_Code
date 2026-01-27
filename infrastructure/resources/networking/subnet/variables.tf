variable "name" {
  description = "Name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_prefixes" {
  description = "List of address prefixes for the subnet"
  type        = list(string)
}

variable "subnet_optional" {
  description = "Optional settings for the subnet"
  type = object({
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
  })
}

variable "subnet_optional_block" {
  description = "Optional blocks for the subnet"
  type = object({
    delegation = optional(list(object({
      name = string
      service_delegation = list(object({
        name    = string
        actions = optional(list(string))
      }))
    })), [])
  })
}
