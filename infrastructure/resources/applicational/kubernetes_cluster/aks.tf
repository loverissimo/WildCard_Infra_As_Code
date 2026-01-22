data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  // Optionals
  sku_tier                            = var.aks_optional.sku_tier # Defaults to Free
  dns_prefix                          = var.aks_optional.dns_prefix
  tags                                = var.aks_optional.tags
  kubernetes_version                  = var.aks_optional.version # If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).
  dns_prefix_private_cluster          = var.aks_optional.dns_prefix_private_cluster
  azure_policy_enabled                = var.aks_optional.azure_policy_enabled
  disk_encryption_set_id              = var.aks_optional.disk_encryption_set_id
  edge_zone                           = var.aks_optional.edge_zone
  http_application_routing_enabled    = var.aks_optional.http_application_routing_enabled
  image_cleaner_enabled               = var.aks_optional.image_cleaner_enabled
  image_cleaner_interval_hours        = var.aks_optional.image_cleaner_interval_hours
  local_account_disabled              = var.aks_optional.local_account_disabled # If local_account_disabled is set to true, it is required to enable Kubernetes RBAC and AKS-managed Azure AD integration. See the documentation for more information.
  node_resource_group                 = var.aks_optional.node_resource_group # Azure requires that a new, non-existent Resource Group is used, as otherwise, the provisioning of the Kubernetes Service will fail.
  oidc_issuer_enabled                 = var.aks_optional.oidc_issuer_enabled
  open_service_mesh_enabled           = var.aks_optional.open_service_mesh_enabled
  private_cluster_enabled             = var.aks_optional.private_cluster_enabled
  private_dns_zone_id                 = var.aks_optional.private_dns_zone_id
  private_cluster_public_fqdn_enabled = var.aks_optional.private_cluster_public_fqdn_enabled # Default to false
  workload_identity_enabled           = var.aks_optional.workload_identity_enabled           # To enable Azure AD Workload Identity oidc_issuer_enabled must be set to true
  role_based_access_control_enabled   = var.aks_optional.role_based_access_control_enabled   # Defaults to true
  run_command_enabled                 = var.aks_optional.run_command_enabled
  #public_network_access_enabled = var.aks_optional.public_network_access_enabled #Deprecated # Default to true



  dynamic "default_node_pool" {
    for_each = var.node_pool_required_block.default_node_pool != null ? [1] : []
    content {
      name           = var.node_pool_required_block.default_node_pool.name
      type           = var.node_pool_required_block.default_node_pool.type
      vm_size        = var.node_pool_required_block.default_node_pool.vm_size
      vnet_subnet_id = var.node_pool_required_block.default_node_pool.vnet_subnet_id
      # If enable_auto_scaling = true, specify the following: node_count, max_count & min_count
      node_count                    = var.node_pool_required_block.default_node_pool.node_count
      max_count                     = var.node_pool_required_block.default_node_pool.max_count
      min_count                     = var.node_pool_required_block.default_node_pool.min_count
      capacity_reservation_group_id = var.node_pool_required_block.default_node_pool.capacity_reservation_group_id
      tags                          = var.node_pool_required_block.default_node_pool.tags
      host_group_id                 = var.node_pool_required_block.default_node_pool.host_group_id
      fips_enabled                  = var.node_pool_required_block.default_node_pool.fips_enabled
      kubelet_disk_type             = var.node_pool_required_block.default_node_pool.kubelet_disk_type
      max_pods                      = var.node_pool_required_block.default_node_pool.max_pods
      node_public_ip_prefix_id      = var.node_pool_required_block.default_node_pool.node_public_ip_prefix_id
      node_labels                   = var.node_pool_required_block.default_node_pool.node_labels
      only_critical_addons_enabled  = var.node_pool_required_block.default_node_pool.only_critical_addons_enabled
      orchestrator_version          = var.node_pool_required_block.default_node_pool.orchestrator_version
      os_disk_size_gb               = var.node_pool_required_block.default_node_pool.os_disk_size_gb
      os_disk_type                  = var.node_pool_required_block.default_node_pool.os_disk_type
      os_sku                        = var.node_pool_required_block.default_node_pool.os_sku
      pod_subnet_id                 = var.node_pool_required_block.default_node_pool.pod_subnet_id
      proximity_placement_group_id  = var.node_pool_required_block.default_node_pool.proximity_placement_group_id
      scale_down_mode               = var.node_pool_required_block.default_node_pool.scale_down_mode
      snapshot_id                   = var.node_pool_required_block.default_node_pool.snapshot_id
      temporary_name_for_rotation   = var.node_pool_required_block.default_node_pool.temporary_name_for_rotation
      ultra_ssd_enabled             = var.node_pool_required_block.default_node_pool.ultra_ssd_enabled
      workload_runtime              = var.node_pool_required_block.default_node_pool.workload_runtime
      zones                         = var.node_pool_required_block.default_node_pool.zones

      dynamic "kubelet_config" {
        for_each = var.node_pool_required_block.default_node_pool.kubelet_config != null ? [1] : []
        content {
          allowed_unsafe_sysctls    = var.node_pool_required_block.default_node_pool.kubelet_config
          container_log_max_line    = var.node_pool_required_block.default_node_pool.kubelet_config.container_log_max_line
          container_log_max_size_mb = var.node_pool_required_block.default_node_pool.kubelet_config.container_log_max_line
          cpu_cfs_quota_enabled     = var.node_pool_required_block.default_node_pool.kubelet_config.cpu_cfs_quota_enabled
          cpu_cfs_quota_period      = var.node_pool_required_block.default_node_pool.kubelet_config.cpu_cfs_quota_period
          cpu_manager_policy        = var.node_pool_required_block.default_node_pool.kubelet_config.cpu_manager_policy
          image_gc_high_threshold   = var.node_pool_required_block.default_node_pool.kubelet_config.image_gc_high_threshold
          image_gc_low_threshold    = var.node_pool_required_block.default_node_pool.kubelet_config.image_gc_low_threshold
          pod_max_pid               = var.node_pool_required_block.default_node_pool.kubelet_config.pod_max_pid
          topology_manager_policy   = var.node_pool_required_block.default_node_pool.kubelet_config.topology_manager_policy
        }
      }

      dynamic "linux_os_config" {
        for_each = var.node_pool_required_block.default_node_pool.linux_os_config != null ? [1] : []
        content {
          swap_file_size_mb             = var.aks_optional_blocks.linux_os_config.swap_file_size_mb
          transparent_huge_page_defrag  = var.aks_optional_blocks.linux_os_config.transparent_huge_page_defrag
          dynamic "sysctl_config" {
            for_each = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config != null ? [1] : []
            content {
              fs_aio_max_nr                      = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.fs_aio_max_nr
              fs_file_max                        = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.fs_file_max
              fs_inotify_max_user_watches        = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.fs_inotify_max_user_watches
              fs_nr_open                         = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.fs_nr_open
              kernel_threads_max                 = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.kernel_threads_max
              net_core_netdev_max_backlog        = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_netdev_max_backlog
              net_core_optmem_max                = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_optmem_max
              net_core_rmem_default              = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_rmem_default
              net_core_rmem_max                  = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_rmem_max
              net_core_somaxconn                 = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_somaxconn
              net_core_wmem_default              = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_wmem_default
              net_core_wmem_max                  = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_core_wmem_max
              net_ipv4_ip_local_port_range_max   = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_ip_local_port_range_max
              net_ipv4_ip_local_port_range_min   = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_ip_local_port_range_min
              net_ipv4_neigh_default_gc_thresh1  = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_neigh_default_gc_thresh1
              net_ipv4_neigh_default_gc_thresh2  = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_neigh_default_gc_thresh2
              net_ipv4_neigh_default_gc_thresh3  = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_neigh_default_gc_thresh3
              net_ipv4_tcp_fin_timeout           = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_fin_timeout
              net_ipv4_tcp_keepalive_intvl       = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_keepalive_intvl
              net_ipv4_tcp_keepalive_probes      = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_keepalive_probes
              net_ipv4_tcp_keepalive_time        = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_keepalive_time
              net_ipv4_tcp_max_syn_backlog       = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_max_syn_backlog
              net_ipv4_tcp_max_tw_buckets        = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_max_tw_buckets
              net_ipv4_tcp_tw_reuse              = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_tw_reuse
              net_netfilter_nf_conntrack_buckets = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_netfilter_nf_conntrack_buckets
              net_netfilter_nf_conntrack_max     = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.net_netfilter_nf_conntrack_max
              vm_max_map_count                   = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.vm_max_map_count
              vm_swappiness                      = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.vm_swappiness
              vm_vfs_cache_pressure              = var.node_pool_required_block.default_node_pool.linux_os_config.sysctl_config.vm_vfs_cache_pressure
            }
          }
        }
      }

      dynamic "node_network_profile" {
        for_each = var.node_pool_required_block.default_node_pool.node_network_profile != null ? [1] : []
        content {
          node_public_ip_tags = var.node_pool_required_block.default_node_pool.node_network_profile.node_public_ip_tags
        }
      }

      dynamic "upgrade_settings" {
        for_each = var.node_pool_required_block.default_node_pool.upgrade_settings != null ? [1] : []
        content {
          max_surge = var.node_pool_required_block.default_node_pool.upgrade_settings.max_surge
        }
      }
    }
  }

  dynamic "aci_connector_linux" {
    for_each = var.aks_optional_blocks.aci_connector_linux != null ? [1] : []
    content {
      subnet_name = var.aks_optional_blocks.subnet_name
    }
  }

  dynamic "api_server_access_profile" { # This requires that the Preview Feature Microsoft.ContainerService/EnableAPIServerVnetIntegrationPreview is enabled and the Resource Provider is re-registered
    for_each = var.aks_optional_blocks.api_server_access_profile != null ? [1] : []
    content {
      authorized_ip_ranges     = var.aks_optional_blocks.api_server_access_profile.authorized_ip_ranges
      subnet_id                = var.aks_optional_blocks.api_server_access_profile.subnet_id
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = var.aks_optional_blocks.auto_scaler_profile != null ? [1] : []
    content {
      balance_similar_node_groups      = var.aks_optional_blocks.auto_scaler_profile.balance_similar_node_groups # Defaults to false
      expander                         = var.aks_optional_blocks.auto_scaler_profile.expander
      max_graceful_termination_sec     = var.aks_optional_blocks.auto_scaler_profile.max_graceful_termination_sec     #Defaults to 600
      max_node_provisioning_time       = var.aks_optional_blocks.auto_scaler_profile.max_node_provisioning_time       #Defaults to 15 min
      max_unready_nodes                = var.aks_optional_blocks.auto_scaler_profile.max_unready_nodes                #Defaults to 3
      max_unready_percentage           = var.aks_optional_blocks.auto_scaler_profile.max_unready_percentage           #Defaults to 45
      new_pod_scale_up_delay           = var.aks_optional_blocks.auto_scaler_profile.new_pod_scale_up_delay           #Defaults to 10s
      scale_down_delay_after_add       = var.aks_optional_blocks.auto_scaler_profile.scale_down_delay_after_add       #Defaults to 10min
      scale_down_delay_after_delete    = var.aks_optional_blocks.auto_scaler_profile.scale_down_delay_after_delete    #Defaults to Scan Interval value
      scale_down_delay_after_failure   = var.aks_optional_blocks.auto_scaler_profile.scale_down_delay_after_failure   #Defaults to 3min
      scan_interval                    = var.aks_optional_blocks.auto_scaler_profile.scan_interval                    #Defaults to 10s
      scale_down_unneeded              = var.aks_optional_blocks.auto_scaler_profile.scale_down_unneeded              #Defaults to 10min
      scale_down_unready               = var.aks_optional_blocks.auto_scaler_profile.scale_down_unready               #Defaults to 20min
      scale_down_utilization_threshold = var.aks_optional_blocks.auto_scaler_profile.scale_down_utilization_threshold #Defaults to 0.5
      empty_bulk_delete_max            = var.aks_optional_blocks.auto_scaler_profile.empty_bulk_delete_max            #Defaults to 10
      skip_nodes_with_local_storage    = var.aks_optional_blocks.auto_scaler_profile.skip_nodes_with_local_storage    #Defaults to true
      skip_nodes_with_system_pods      = var.aks_optional_blocks.auto_scaler_profile.skip_nodes_with_system_pods      #Defaults to true
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.aks_optional_blocks.azure_active_directory_role_based_access_control != null ? [1] : []
    content {
      // If managed = true, specify the following properties: admin_group_object_ids & azure_rbac_enabled
      admin_group_object_ids = var.aks_optional_blocks.azure_active_directory_role_based_access_control.admin_group_object_ids
      azure_rbac_enabled     = var.aks_optional_blocks.azure_active_directory_role_based_access_control.azure_rbac_enabled
      // If managed = false, specify the following properties: client_app_id, server_app_id & server_app_secret
      tenant_id         = var.aks_optional_blocks.azure_active_directory_role_based_access_control.tenant_id #If this isn't specified the Tenant ID of the current Subscription is used.
    }
  }

  dynamic "confidential_computing" {
    for_each = var.aks_optional_blocks.confidential_computing != null ? [1] : []
    content {
      sgx_quote_helper_enabled = var.aks_optional_blocks.confidential_computing.sgx_quote_helper_enabled # Required
    }
  }

  dynamic "identity" {
    for_each = var.aks_optional_blocks.identity != null ? [1] : []
    content {
      type         = var.aks_optional_blocks.identity.type
      identity_ids = var.aks_optional_blocks.identity.identity_ids
    }
  }

  dynamic "ingress_application_gateway" { #Since the Application Gateway is deployed inside a Virtual Network, users (and Service Principals) that are operating the Application Gateway must have the Microsoft.Network/virtualNetworks/subnets/join/action permission on the Virtual Network or Subnet. For more details, please visit Virtual Network Permission.
    for_each = var.aks_optional_blocks.ingress_application_gateway != null ? [1] : []
    content {
      gateway_id   = var.aks_optional_blocks.ingress_application_gateway.gateway_id   # ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster
      gateway_name = var.aks_optional_blocks.ingress_application_gateway.gateway_name # Name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster
      subnet_cidr  = var.aks_optional_blocks.ingress_application_gateway.subnet_cidr  # The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster
      subnet_id    = var.aks_optional_blocks.ingress_application_gateway.subnet_id    # ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster
    }
  }

  dynamic "http_proxy_config" {
    for_each = var.aks_optional_blocks.http_proxy_config != null ? [1] : []
    content {
      http_proxy  = var.aks_optional_blocks.http_proxy_config.http_proxy # The proxy address to be used when communicating over HTTP.
      https_proxy = var.aks_optional_blocks.http_proxy_config.http_proxy # The proxy address to be used when communicating over HTTPS.
      no_proxy    = var.aks_optional_blocks.http_proxy_config.http_proxy # The list of domains that will not use the proxy for communication.
    }
  }

  dynamic "monitor_metrics" {
    for_each = var.aks_optional_blocks.monitor_metrics != null ? [1] : []
    content {
      annotations_allowed = var.aks_optional_blocks.monitor_metrics.annotations_allowed # List
      labels_allowed      = var.aks_optional_blocks.monitor_metrics.annotations_allowed # list
    }
  }

  dynamic "key_management_service" {
    for_each = var.aks_optional_blocks.key_management_service != null ? [1] : []
    content {
      key_vault_key_id         = var.aks_optional_blocks.key_management_service.key_vault_key_id
      key_vault_network_access = var.aks_optional_blocks.key_management_service.key_vault_network_access

    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.aks_optional_blocks.key_vault_secrets_provider != null ? [1] : []
    content {
      secret_rotation_enabled  = var.aks_optional_blocks.key_vault_secrets_provider.secret_rotation_enabled
      secret_rotation_interval = var.aks_optional_blocks.key_vault_secrets_provider.secret_rotation_interval
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.aks_optional_blocks.kubelet_identity != null ? [1] : []
    content {
      client_id                 = var.aks_optional_blocks.kubelet_identity.client_id
      object_id                 = var.aks_optional_blocks.kubelet_identity.object_id
      user_assigned_identity_id = var.aks_optional_blocks.kubelet_identity.user_assigned_identity_id
    }
  }

  dynamic "linux_profile" {
    for_each = var.aks_optional_blocks.linux_profile != null ? [1] : []
    content {
      admin_username = var.aks_optional_blocks.linux_profile.admin_username

      dynamic "ssh_key" {
        for_each = var.aks_optional_blocks.linux_profile.ssh_key
        content {
          key_data = var.aks_optional_blocks.linux_profile.ssh_key.key_data
        }
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = var.aks_optional_blocks.maintenance_window != null ? [1] : []
    content {
      dynamic "allowed" {
        for_each = var.aks_optional_blocks.maintenance_window.allowed != null ? [1] : []
        content {
          day   = var.aks_optional_blocks.maintenance_window.allowed.day # Possible values are Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday
          hours = var.aks_optional_blocks.maintenance_window.allowed.hours
        }
      }

      dynamic "not_allowed" {
        for_each = var.aks_optional_blocks.maintenance_window.not_allowed != null ? [1] : []
        content {
          end   = var.aks_optional_blocks.maintenance_window.not_allowed.end
          start = var.aks_optional_blocks.maintenance_window.not_allowed.start
        }
      }
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = var.aks_optional_blocks.maintenance_window_auto_upgrade != null ? [1] : []
    content {
      frequency    = var.aks_optional_blocks.maintenance_window_auto_upgrade.frequency # Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      interval     = var.aks_optional_blocks.maintenance_window_auto_upgrade
      duration     = var.aks_optional_blocks.maintenance_window_auto_upgrade.duration
      day_of_week  = var.aks_optional_blocks.maintenance_window_auto_upgrade.day_of_week
      day_of_month = var.aks_optional_blocks.maintenance_window_auto_upgrade.day_of_month
      week_index   = var.aks_optional_blocks.maintenance_window_auto_upgrade.week_index
      start_time   = var.aks_optional_blocks.maintenance_window_auto_upgrade.start_time
      utc_offset   = var.aks_optional_blocks.maintenance_window_auto_upgrade.utc_offset
      start_date   = var.aks_optional_blocks.maintenance_window_auto_upgrade.start_date
      dynamic "not_allowed" {
        for_each = var.aks_optional_blocks.maintenance_window_auto_upgrade.not_allowed != null ? [1] : []
        content {
          end   = var.aks_optional_blocks.maintenance_window.not_allowed.end
          start = var.aks_optional_blocks.maintenance_window.not_allowed.start
        }
      }
    }
  }

  dynamic "maintenance_window_node_os" {
    for_each = var.aks_optional_blocks.maintenance_window_node_os != null ? [1] : []
    content {
      frequency    = var.aks_optional_blocks.maintenance_window_node_os.frequency # Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      interval     = var.aks_optional_blocks.maintenance_window_node_os.interval
      duration     = var.aks_optional_blocks.maintenance_window_node_os.duration
      day_of_week  = var.aks_optional_blocks.maintenance_window_node_os.day_of_week
      day_of_month = var.aks_optional_blocks.maintenance_window_node_os.day_of_month
      week_index   = var.aks_optional_blocks.maintenance_window_node_os.week_index
      start_time   = var.aks_optional_blocks.maintenance_window_node_os.start_time
      utc_offset   = var.aks_optional_blocks.maintenance_window_node_os.utc_offset
      start_date   = var.aks_optional_blocks.maintenance_window_node_os.start_date
      dynamic "not_allowed" {
        for_each = var.aks_optional_blocks.maintenance_window_node_os.not_allowed != null ? [1] : []
        content {
          end   = var.aks_optional_blocks.maintenance_window_node_os.not_allowed.end
          start = var.aks_optional_blocks.maintenance_window_node_os.not_allowed.start
        }
      }
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.aks_optional_blocks.microsoft_defender != null ? [1] : []
    content {
      log_analytics_workspace_id = var.aks_optional_blocks.microsoft_defender.log_analytics_workspace_id
    }
  }

  dynamic "network_profile" { #If network_profile is not defined, kubenet profile will be used by default.
    for_each = var.aks_optional_blocks.network_profile != null ? [1] : []
    content {
      network_plugin      = var.aks_optional_blocks.network_profile.network_plugin
      network_mode        = var.aks_optional_blocks.network_profile.network_mode   # Possible values are bridge and transparent
      network_policy      = var.aks_optional_blocks.network_profile.network_policy # Currently supported values are calico, azure and cilium. When network_policy is set to cilium, the ebpf_data_plane field must be set to cilium.
      dns_service_ip      = var.aks_optional_blocks.network_profile.dns_service_ip
      network_plugin_mode = var.aks_optional_blocks.network_profile.network_plugin_mode # Possible value is overlay.
      outbound_type       = var.aks_optional_blocks.network_profile.outbound_type       # Defaults to loadBalancer. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. 
      pod_cidr            = var.aks_optional_blocks.network_profile.pod_cidr
      pod_cidrs           = var.aks_optional_blocks.network_profile.pod_cidrs
      service_cidr        = var.aks_optional_blocks.network_profile.service_cidr
      service_cidrs       = var.aks_optional_blocks.network_profile.service_cidrs     # This range should not be used by any network element on or connected to this VNet. Service address CIDR must be smaller than /12. docker_bridge_cidr, dns_service_ip and service_cidr should all be empty or all should be set.
      ip_versions         = var.aks_optional_blocks.network_profile.ip_versions       # Possible values are IPv4 and/or IPv6. IPv4 must always be specified. 
      load_balancer_sku   = var.aks_optional_blocks.network_profile.load_balancer_sku # Defaults to standard. Possible values are basic and standard

      dynamic "load_balancer_profile" {
        for_each = var.aks_optional_blocks.network_profile.load_balancer_profile != null ? [1] : []
        content {
          idle_timeout_in_minutes     = var.aks_optional_blocks.network_profile.load_balancer_profile.idle_timeout_in_minutes
          managed_outbound_ip_count   = var.aks_optional_blocks.network_profile.load_balancer_profile.managed_outbound_ip_count
          managed_outbound_ipv6_count = var.aks_optional_blocks.network_profile.load_balancer_profile.managed_outbound_ipv6_count
          outbound_ip_address_ids     = var.aks_optional_blocks.network_profile.load_balancer_profile.outbound_ip_address_ids
          outbound_ip_prefix_ids      = var.aks_optional_blocks.network_profile.load_balancer_profile.outbound_ip_prefix_ids
        }
      }

      dynamic "nat_gateway_profile" { # This can only be specified when load_balancer_sku is set to standard and outbound_type is set to managedNATGateway or userAssignedNATGateway
        for_each = var.aks_optional_blocks.network_profile.nat_gateway_profile != null ? [1] : []
        content {
          idle_timeout_in_minutes   = var.aks_optional_blocks.network_profile.nat_gateway_profile.idle_timeout_in_minutes
          managed_outbound_ip_count = var.aks_optional_blocks.network_profile.nat_gateway_profile.managed_outbound_ip_count
        }
      }
    }
  }

  dynamic "oms_agent" {
    for_each = var.aks_optional_blocks.oms_agent != null ? [1] : []
    content {
      log_analytics_workspace_id      = var.aks_optional_blocks.oms_agent.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = var.aks_optional_blocks.oms_agent.msi_auth_for_monitoring_enabled

    }
  }

  dynamic "service_principal" {
    for_each = var.aks_optional_blocks.service_principal != null ? [1] : []
    content {
      client_id     = var.aks_optional_blocks.service_principal.client_id
      client_secret = var.aks_optional_blocks.service_principal.client_secret
    }
  }

  dynamic "storage_profile" {
    for_each = var.aks_optional_blocks.storage_profile != null ? [1] : []
    content {
      blob_driver_enabled         = var.aks_optional_blocks.storage_profile.blob_driver_enabled         # Defaults to false
      disk_driver_enabled         = var.aks_optional_blocks.storage_profile.disk_driver_enabled         # Defaults to true
      file_driver_enabled         = var.aks_optional_blocks.storage_profile.file_driver_enabled         # Defaults to true
      snapshot_controller_enabled = var.aks_optional_blocks.storage_profile.snapshot_controller_enabled # Defaults to true

    }
  }

  dynamic "windows_profile" {
    for_each = var.aks_optional_blocks.windows_profile != null ? [1] : []
    content {
      admin_username = var.aks_optional_blocks.windows_profile.admin_username # Admin Username for Windows VMs. 
      admin_password = var.aks_optional_blocks.windows_profile.admin_password # Admin Password for Windows VMs. Length must be between 14 and 123 characters.
      license        = var.aks_optional_blocks.windows_profile.license        # At this time the only possible value is Windows_Server.
      dynamic "gmsa" {
        for_each = var.aks_optional_blocks.windows_profile.gmsa
        content {
          dns_server  = var.aks_optional_blocks.windows_profile.gmsa.dns_server # Specifies the DNS server for Windows gMSA. Set this to an empty string if you have configured the DNS server in the VNet which was used to create the managed cluster
          root_domain = var.aks_optional_blocks.windows_profile.gmsa.root_domain
        }
      }
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.aks_optional_blocks.workload_autoscaler_profile != null ? [1] : []
    content {
      keda_enabled                    = var.aks_optional_blocks.workload_autoscaler_profile.keda_enabled
      vertical_pod_autoscaler_enabled = var.aks_optional_blocks.workload_autoscaler_profile.vertical_pod_autoscaler_enabled
    }
  }

}
