variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "vnet_optional" {
  description = "Optional settings for the virtual network"
  type = object({
    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string))
  })
}

variable "vnet_optional_block" {
  description = "Optional blocks for the virtual network"
  type = object({
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }), null)
    subnet = optional(map(object({
      name           = string
      security_group = optional(string)
    })), {})
  })
}
