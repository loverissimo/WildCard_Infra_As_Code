output "id" {
  description = "The ID of the created role assignment."
  value       = azurerm_role_assignment.role_assignment.id
}

output "principal_id" {
  description = "The Principal ID associated with the role_assignment."
  value       = azurerm_role_assignment.role_assignment.principal_id
}
