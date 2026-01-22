
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  bgp_community           = var.vnet_optional.bgp_community
  dns_servers             = var.vnet_optional.dns_servers
  edge_zone               = var.vnet_optional.edge_zone
  flow_timeout_in_minutes = var.vnet_optional.flow_timeout_in_minutes
  tags                    = var.vnet_optional.tags

  dynamic "ddos_protection_plan" {
    for_each = var.vnet_optional_block.ddos_protection_plan != null ? [1] : []
    content {
      id     = var.vnet_optional_block.ddos_protection_plan.id
      enable = var.vnet_optional_block.ddos_protection_plan.enable
    }
  }

  dynamic "subnet" {
    for_each = var.vnet_optional_block.subnet
    content {
      name           = var.vnet_optional_block.subnet.value.name
      security_group = var.vnet_optional_block.subnet.value.security_group
    }
  }
}
