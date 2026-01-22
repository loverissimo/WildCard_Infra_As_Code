
resource "azurerm_role_assignment" "role_assignment" {
  scope        = var.scope
  principal_id = var.principal_id

  name                                   = var.role_assignment_optional.name
  role_definition_id                     = var.role_assignment_optional.role_definition_id
  role_definition_name                   = var.role_assignment_optional.role_definition_name
  condition                              = var.role_assignment_optional.condition
  condition_version                      = var.role_assignment_optional.condition_version
  delegated_managed_identity_resource_id = var.role_assignment_optional.delegated_managed_identity_resource_id
  description                            = var.role_assignment_optional.description
  skip_service_principal_aad_check       = var.role_assignment_optional.skip_service_principal_aad_check
}
