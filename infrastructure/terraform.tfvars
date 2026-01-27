rg_name     = "rg-wc-weu"

vnet_name          = "vnet-wc-weu"
vnet_address_space = ["10.10.0.0/24"]

subnet_name             = "snet-aks"
subnet_address_prefixes = ["10.10.0.0/25"]

acr_name = "acrwcweu"
acr_sku  = "Basic"

aks_cluster_name = "aks-wc-weu"