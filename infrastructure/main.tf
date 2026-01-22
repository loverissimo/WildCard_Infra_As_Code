module "rg" {
  source = "./resources/management/resource_group"
  name = var.rg_name
  location = var.rg_location
  tags = local.tags
}

module "vnet" {
  source = "./resources/networking/virtual_network"
  name = var.vnet_name
  resource_group_name = module.rg.name
  location = module.rg.location
  address_space = var.vnet_address_space

  vnet_optional = {
    tags = local.tags
  }
  vnet_optional_block = {}
}

module "subnet" {
  source = "./resources/networking/subnet"
  name = var.subnet_name
  resource_group_name = module.rg.name
  virtual_network_name = module.vnet.name
  address_prefixes = var.subnet_address_prefixes

  subnet_optional = {}
  subnet_optional_block = {}
}

module "acr" {
  source = "./resources/applicational/container_registry"
  name = var.acr_name
  resource_group_name = module.rg.name
  location = module.rg.location
  sku = var.acr_sku

  acr_optional = {
    tags = local.tags
  }

  acr_optional_block = {}
}

# module "aks_cluster" {
#   source = "./resources/applicational/kubernetes_cluster"
#   name = var.aks_cluster_name
#   location = module.rg.location
#   resource_group_name = module.rg.name

#   node_pool_required_block = {}

#   aks_optional = {
#     tags = local.tags
#   }
  
#   aks_optional_blocks = {}
# }