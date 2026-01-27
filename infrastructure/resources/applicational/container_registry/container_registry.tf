resource "azurerm_container_registry" "container_registry" {
  name                = var.name                #"containerRegistry1"
  resource_group_name = var.resource_group_name #azurerm_resource_group.example.name
  location            = var.location            #azurerm_resource_group.example.location
  sku                 = var.sku                 #"Premium"

  admin_enabled                 = var.acr_optional.admin_enabled #false
  public_network_access_enabled = var.acr_optional.public_network_access_enabled
  quarantine_policy_enabled     = var.acr_optional.quarantine_policy_enabled
  zone_redundancy_enabled       = var.acr_optional.zone_redundancy_enabled
  export_policy_enabled         = var.acr_optional.export_policy_enabled
  anonymous_pull_enabled        = var.acr_optional.anonymous_pull_enabled
  data_endpoint_enabled         = var.acr_optional.data_endpoint_enabled
  network_rule_bypass_option    = var.acr_optional.network_rule_bypass_option
  tags                          = var.acr_optional.tags

  dynamic "georeplications" {
    for_each = var.acr_optional_block.georeplications != null ? [1] : []
    content {
      location                  = var.acr_optional_block.georeplications.location
      regional_endpoint_enabled = var.acr_optional_block.georeplications.regional_endpoint_enabled
      zone_redundancy_enabled   = var.acr_optional_block.georeplications.zone_redundancy_enabled
      tags                      = var.acr_optional_block.georeplications.tags
    }
  }

  /* dynamic "network_rule_set" { #NOTE - it is only supported with the Premium SKU
    for_each = var.acr_optional_block.network_rule_set != null ? [1] : []
    content {
      default_action = var.acr_optional_block.network_rule_set.default_action

      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rule
        content {
          action   = ip_rule.value.action
          ip_range = ip_rule.value.ip_range
        }
      }

      dynamic "virtual_network" {
        for_each = network_rule_set.value.virtual_network
        content {
          action    = virtual_network.value.action
          subnet_id = virtual_network.value.subnet_id
        }
      }
    }
  } */

  dynamic "identity" {
    for_each = var.acr_optional_block.identity != null ? [1] : []
    content {
      type         = var.acr_optional_block.identity.type
      identity_ids = var.acr_optional_block.identity.identity_ids
    }
  }

  dynamic "encryption" {
    for_each = var.acr_optional_block.encryption != null ? [1] : []
    content {
      key_vault_key_id   = var.acr_optional_block.encryption.key_vault_id
      identity_client_id = var.acr_optional_block.encryption.identity_client_id
    }
  }
}
