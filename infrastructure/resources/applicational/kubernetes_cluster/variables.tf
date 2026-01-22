variable "name" {
  description = "Name of the Azure Kubernetes Service."
  type        = string
}

variable "location" {
  description = "Location of the Azure Kubernetes Service."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name of the Azure Kubernetes Service."
  type        = string
}

variable "node_pool_required_block" {
  description = "Configuration of the AKS node pool."
  type = object({
    default_node_pool = object({
      vm_size                       = string
      name                          = string
      type                          = optional(string) # Defaults to VirtualMachineScaleSets
      vnet_subnet_id                = optional(string)
      capacity_reservation_group_id = optional(number)
      node_count                    = optional(number) # If enable_auto_scaling = true, specify
      max_count                     = optional(number) # If enable_auto_scaling = true, specify
      min_count                     = optional(number) # If enable_auto_scaling = true, specify
      custom_ca_trust_enabled       = optional(bool)   # This requires that the Preview Feature Microsoft.ContainerService/CustomCATrustPreview is enabled and the Resource Provider is re-registered
      enable_auto_scaling           = optional(bool)   # This requires that the type is set to VirtualMachineScaleSets.
      tags                          = optional(map(string))
      enable_node_public_ip         = optional(bool)
      enable_host_encryption        = optional(bool) # This requires that the Preview Feature Microsoft.ContainerService/EnableEncryptionAtHostPreview is enabled and the Resource Provider is re-registered.
      host_group_id                 = optional(number)
      fips_enabled                  = optional(bool)
      kubelet_disk_type             = optional(string)
      max_pods                      = optional(number)
      message_of_the_day            = optional(string)
      node_public_ip_prefix_id      = optional(number) # enable_node_public_ip should be true
      node_labels                   = optional(map(string))
      node_taints                   = optional(list(string))
      only_critical_addons_enabled  = optional(bool) # Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint. 
      orchestrator_version          = optional(number)
      os_disk_size_gb               = optional(number)
      os_disk_type                  = optional(string)
      os_sku                        = optional(string)
      pod_subnet_id                 = optional(number)
      proximity_placement_group_id  = optional(number)
      scale_down_mode               = optional(string) # Defaults to Delete.
      snapshot_id                   = optional(number)
      temporary_name_for_rotation   = optional(string)
      ultra_ssd_enabled             = optional(bool)
      workload_runtime              = optional(string)
      zones                         = optional(list(string)) # Requires that the type is set to VirtualMachineScaleSets and that load_balancer_sku is set to standard.

      kubelet_config = optional(object({
        allowed_unsafe_sysctls    = optional(list(string))
        container_log_max_line    = optional(number)
        container_log_max_size_mb = optional(number)
        cpu_cfs_quota_enabled     = optional(bool)
        cpu_cfs_quota_period      = optional(number)
        cpu_manager_policy        = optional(string) # Possible values are none and static,.
        image_gc_high_threshold   = optional(number)
        image_gc_low_threshold    = optional(number)
        pod_max_pid               = optional(number)
        topology_manager_policy   = optional(string) # Possible values are none, best-effort, restricted or single-numa-node.
      }))

      linux_os_config = optional(object({
        swap_file_size_mb             = optional(number)
        transparent_huge_page_defrag  = optional(string) # Possible values are always, defer, defer+madvise, madvise and never.
        transparent_huge_page_enabled = optional(string) #Possible values are always, madvise and never.

        sysctl_config = optional(object({
          fs_aio_max_nr                      = optional(number)
          fs_file_max                        = optional(number)
          fs_inotify_max_user_watches        = optional(number)
          fs_nr_open                         = optional(number)
          kernel_threads_max                 = optional(number)
          net_core_netdev_max_backlog        = optional(number)
          net_core_optmem_max                = optional(number)
          net_core_rmem_default              = optional(number)
          net_core_rmem_max                  = optional(number)
          net_core_somaxconn                 = optional(number)
          net_core_wmem_default              = optional(number)
          net_core_wmem_max                  = optional(number)
          net_ipv4_ip_local_port_range_max   = optional(number)
          net_ipv4_ip_local_port_range_min   = optional(number)
          net_ipv4_neigh_default_gc_thresh1  = optional(number)
          net_ipv4_neigh_default_gc_thresh2  = optional(number)
          net_ipv4_neigh_default_gc_thresh3  = optional(number)
          net_ipv4_tcp_fin_timeout           = optional(number)
          net_ipv4_tcp_keepalive_intvl       = optional(number)
          net_ipv4_tcp_keepalive_probes      = optional(number)
          net_ipv4_tcp_keepalive_time        = optional(number)
          net_ipv4_tcp_max_syn_backlog       = optional(number)
          net_ipv4_tcp_max_tw_buckets        = optional(number)
          net_ipv4_tcp_tw_reuse              = optional(number)
          net_netfilter_nf_conntrack_buckets = optional(number)
          net_netfilter_nf_conntrack_max     = optional(number)
          vm_max_map_count                   = optional(number)
          vm_swappiness                      = optional(number)
          vm_vfs_cache_pressure              = optional(number)
        }))
      }))

      node_network_profile = optional(object({
        node_public_ip_tags = optional(map(string)) # This requires that the Preview Feature Microsoft.ContainerService/NodePublicIPTagsPreview is enabled 
      }))

      upgrade_settings = optional(object({ # If a percentage is provided, the number of surge nodes is calculated from the node_count value on the current cluster. Node surge can allow a cluster to have more nodes than max_count during an upgrade. Ensure that your cluster has enough IP space during an upgrade.
        max_surge = number                 # The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade.
      }))
    })
  })
}

variable "aks_optional" {
  description = "Configuration of AKS optional properties."
  type = object({
    sku_tier                            = optional(string)
    dns_prefix                          = optional(string)
    tags                                = optional(map(string))
    version                             = optional(string)
    dns_prefix_private_cluster          = optional(string)
    automatic_channel_upgrade           = optional(string)
    azure_policy_enabled                = optional(bool)
    disk_encryption_set_id              = optional(number)
    edge_zone                           = optional(string)
    http_application_routing_enabled    = optional(bool)
    image_cleaner_enabled               = optional(bool)
    image_cleaner_interval_hours        = optional(number)
    local_account_disabled              = optional(bool)
    node_os_channel_upgrade             = optional(string)
    node_resource_group                 = optional(string)
    oidc_issuer_enabled                 = optional(bool)
    open_service_mesh_enabled           = optional(bool)
    private_cluster_enabled             = optional(bool)
    private_dns_zone_id                 = optional(number)
    private_cluster_public_fqdn_enabled = optional(bool)
    workload_identity_enabled           = optional(bool)
    public_network_access_enabled       = optional(bool) #Deprecated # Default to true
    role_based_access_control_enabled   = optional(bool)
    run_command_enabled                 = optional(bool)
  })
}

variable "aks_optional_blocks" {
  description = "Configuration of AKS optional blocks"
  type = object({

    aci_connector_linux = optional(object({
      subnet_name = string
    }), null)

    api_server_access_profile = optional(object({
      authorized_ip_ranges     = optional(list(number))
      subnet_id                = optional(number)
      vnet_integration_enabled = optional(bool)
    }), null)

    auto_scaler_profile = optional(object({
      balance_similar_node_groups      = optional(bool)   # Defaults to false
      expander                         = optional(string) # Defaults to random.
      max_graceful_termination_sec     = optional(number) # Defaults to 600
      max_node_provisioning_time       = optional(string) # Defaults to "15m"
      max_unready_nodes                = optional(number) # Defaults to 3
      max_unready_percentage           = optional(number) # Defaults to 45
      new_pod_scale_up_delay           = optional(string) # Defaults to "10s"
      scale_down_delay_after_add       = optional(string) # Defaults to "10m"
      scale_down_delay_after_delete    = optional(string) # Defaults to Scan Interval value
      scale_down_delay_after_failure   = optional(string) # Defaults to "3m"
      scan_interval                    = optional(string) # Defaults to "10s"
      scale_down_unneeded              = optional(string) # Defaults to "10m"
      scale_down_unready               = optional(string) # Defaults to "20m"
      scale_down_utilization_threshold = optional(number) # Defaults to 0.5
      empty_bulk_delete_max            = optional(number) # Defaults to 10
      skip_nodes_with_local_storage    = optional(bool)   # Defaults to true
      skip_nodes_with_system_pods      = optional(bool)   # Defaults to true
    }), null)

    azure_active_directory_role_based_access_control = optional(object({
      managed                = optional(bool)
      admin_group_object_ids = optional(list(string)) #If managed = true, specify
      azure_rbac_enabled     = optional(bool)         #If managed = true, specify
      client_app_id          = optional(string)       #If managed = false, specify
      server_app_id          = optional(string)       #If managed = false, specify
      server_app_secret      = optional(string)       #If managed = false, specify
      tenant_id              = optional(string)
    }), null)

    confidential_computing = optional(object({
      sgx_quote_helper_enabled = bool
    }), null)

    identity = optional(object({
      type         = string                 # Possible values are SystemAssigned or UserAssigned
      identity_ids = optional(list(number)) # Required when type is set to UserAssigned. List of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster.
    }), null)

    ingress_application_gateway = optional(object({
      gateway_id   = optional(string) # Exactly one of gateway_id, subnet_id or subnet_cidr must be specified.
      gateway_name = optional(string)
      subnet_cidr  = optional(number) # Exactly one of gateway_id, subnet_id or subnet_cidr must be specified.
      subnet_id    = optional(string) # Exactly one of gateway_id, subnet_id or subnet_cidr must be specified.
    }), null)


    http_proxy_config = optional(object({
      http_proxy  = optional(number)
      https_proxy = optional(number)
      no_proxy    = optional(list(string))
    }), null)


    monitor_metrics = optional(object({
      annotations_allowed = optional(list(string))
      labels_allowed      = optional(list(string))
    }), null)

    key_management_service = optional(object({
      key_vault_key_id         = number
      key_vault_network_access = optional(string) # Defaults to Public. Possible values are Public and Private. Public means the key vault allows public access from all networks. Private means the key vault disables public access and enables private link.
    }), null)


    key_vault_secrets_provider = optional(object({ # To enable key_vault_secrets_provider either secret_rotation_enabled or secret_rotation_interval must be specified.
      secret_rotation_enabled  = optional(bool)
      secret_rotation_interval = optional(number) # Defaults to 2m
    }), null)

    kubelet_identity = optional(object({           # When kubelet_identity is enabled - The type field in the identity block must be set to UserAssigned and identity_ids must be set.
      client_id                 = optional(number) # The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically. 
      object_id                 = optional(number)
      user_assigned_identity_id = optional(number)
    }), null)

    linux_profile = optional(object({
      admin_username = string # The Admin Username for the Cluster.
      ssh_key = optional(object({
      }), null)
    }), null)

    maintenance_window = optional(object({
      allowed = optional(object({
        day   = optional(string)
        hours = optional(list(string))
      }), null)
      not_allowed = optional(object({
        end   = optional(string)
        start = optional(string)
      }), null)
    }), null)

    maintenance_window_auto_upgrade = optional(object({
      frequency    = optional(string) # Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      interval     = optional(number)
      duration     = optional(number)
      day_of_week  = optional(string)
      day_of_month = optional(number)
      week_index   = optional(string)
      start_time   = optional(string)
      utc_offset   = optional(number)
      start_date   = optional(number)
      not_allowed = optional(object({ # One or more not_allowed block
        end   = optional(string)
        start = optional(string)
      }), null)
    }), null)

    maintenance_window_node_os = optional(object({
      frequency    = optional(string) # Possible options are Weekly, AbsoluteMonthly and RelativeMonthly.
      interval     = optional(number)
      duration     = optional(number)
      day_of_week  = optional(string)
      day_of_month = optional(number)
      week_index   = optional(string)
      start_time   = optional(string)
      utc_offset   = optional(number)
      start_date   = optional(number)
      not_allowed = optional(object({ # One or more not_allowed block
        end   = optional(string)
        start = optional(string)
      }), null)
    }), null)

    microsoft_defender = optional(object({
      log_analytics_workspace_id = optional(number)
    }), null)

    network_profile = optional(object({
      network_plugin      = optional(string) # Currently supported values are azure, kubenet and none
      network_mode        = optional(string)
      network_policy      = optional(string)
      dns_service_ip      = optional(number)
      ebpf_data_plane     = optional(string)
      network_plugin_mode = optional(string)
      outbound_type       = optional(string) # Defaults to loadBalancer. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. 
      pod_cidr            = optional(number)
      pod_cidrs           = optional(list(number))
      service_cidr        = optional(number)
      service_cidrs       = optional(list(number))
      ip_versions         = optional(list(string)) # Possible values are IPv4 and/or IPv6. IPv4 must always be specified. 
      load_balancer_sku   = optional(string)

      load_balancer_profile = optional(object({
        idle_timeout_in_minutes     = optional(number) # Defaults to 30
        managed_outbound_ip_count   = optional(number)
        managed_outbound_ipv6_count = optional(number)
        outbound_ip_address_ids     = optional(list(number))
        outbound_ip_prefix_ids      = optional(list(number))
      }), null)

      nat_gateway_profile = optional(object({
        idle_timeout_in_minutes   = optional(number) # Defaults to 0
        managed_outbound_ip_count = optional(number)
      }), null)
    }), null)

    oms_agent = optional(object({
      log_analytics_workspace_id      = number
      msi_auth_for_monitoring_enabled = optional(bool)
    }), null)

    service_mesh_profile = optional(object({
      mode                             = string
      internal_ingress_gateway_enabled = optional(bool)
      external_ingress_gateway_enabled = optional(bool)
    }), null)

    service_principal = optional(object({
      client_id     = optional(number)
      client_secret = optional(string)
    }))

    storage_profile = optional(object({
      blob_driver_enabled         = optional(bool)
      disk_driver_enabled         = optional(bool)
      disk_driver_version         = optional(number)
      file_driver_enabled         = optional(bool)
      snapshot_controller_enabled = optional(bool)
    }), null)

    web_app_routing = optional(object({
      dns_zone_id = number
    }), null)

    windows_profile = optional(object({
      admin_username = string
      admin_password = optional(string)
      license        = optional(string)

      gmsa = optional(object({
        dns_server  = string
        root_domain = string
      }), null)
    }), null)

    workload_autoscaler_profile = optional(object({
      keda_enabled                    = optional(bool)
      vertical_pod_autoscaler_enabled = optional(bool)
    }), null)
  })
}
