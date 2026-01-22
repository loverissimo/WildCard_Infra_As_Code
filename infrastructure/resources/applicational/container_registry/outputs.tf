output "id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.container_registry.id
}

output "name" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.container_registry.name
}

output "login_server" {
  description = "The URL that can be used to log into the container registry"
  value       = azurerm_container_registry.container_registry.login_server
}

output "admin_username" {
  description = "The Username associated with the Container Registry Admin account (if enabled)"
  value       = azurerm_container_registry.container_registry.admin_username
}

output "admin_password" {
  description = "The Password associated with the Container Registry Admin account (if enabled)"
  value       = azurerm_container_registry.container_registry.admin_password
}

output "identity" {
  description = "Managed Service Identity associated with the Container Registry"
  value       = azurerm_container_registry.container_registry.identity
}
