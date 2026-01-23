terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.24.0"
    }
  }

#   backend "azurerm" {
#     resource_group_name  = "rg-chusp-dev-westeurope-001"
#     storage_account_name = "tfstatechuspdev"
#     container_name       = "tfstatedev"
#     key                  = "terraform.tfstate"
#   }
}

provider "azurerm" {
  features {}

  subscription_id = "d684986e-9ad3-4d0a-a267-cb448ffd6845"
  tenant_id       = "74ac534b-9bef-4eb1-b8bd-0cae4b39c21a"
}