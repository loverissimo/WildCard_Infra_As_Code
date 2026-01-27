resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  # private_endpoint_network_policies_enabled     = var.subnet_optional.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.subnet_optional.private_link_service_network_policies_enabled
  service_endpoints                             = var.subnet_optional.service_endpoints
  service_endpoint_policy_ids                   = var.subnet_optional.service_endpoint_policy_ids

  dynamic "delegation" {
    for_each = var.subnet_optional_block.delegation
    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = delegation.value.service_delegation
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
}
