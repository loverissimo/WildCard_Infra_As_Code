output "id" {
  description = "The Kubernetes Managed Cluster ID."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.fqdn
}

output "private_fqdn" {
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.private_fqdn
}

output "portal_fqdn" {
  description = "The FQDN for the Azure Portal resources when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.portal_fqdn
}

output "kube_admin_config" {
  description = "A kube_admin_config block as defined below. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config
}

output "kube_admin_config_raw" {
  description = "Raw Kubernetes config for the admin account to be used by kubectl and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled and local accounts enabled."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_admin_config_raw
}

output "kube_config" {
  description = "A kube_config block as defined below."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config
}

output "kube_config_raw" {
  description = "Raw Kubernetes config to be used by kubectl and other compatible tools."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config_raw
}

output "http_application_routing_zone_name" {
  description = "The Zone Name of the HTTP Application Routing."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.http_application_routing_zone_name
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.oidc_issuer_url
}

output "node_resource_group" {
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.node_resource_group
}

output "node_resource_group_id" {
  description = "The ID of the Resource Group containing the resources for this Managed Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.node_resource_group_id
}

output "network_profile" {
  description = "A network_profile block as defined below."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.network_profile
}

output "ingress_application_gateway" {
  description = "An ingress_application_gateway block as defined below."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.ingress_application_gateway
}

output "oms_agent" {
  description = "An oms_agent block as defined below."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.oms_agent
}

output "key_vault_secrets_provider" {
  description = "A key_vault_secrets_provider block as defined below."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.key_vault_secrets_provider
}
