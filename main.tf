# terraform {
#   backend "azurerm" {
#     storage_account_name = "examplestorage"
#     container_name       = "terraform-state"
#     key                  = "terraform.tfstate"
#     resource_group_name  = "dev-rg"
#   }
# }

#provisioning resource group
module "Rg-Dev" {
  source = "./modules/azure_resource_group"
  rgname   = "Rg-Dev"
  location = "eastus"
}

module "Rg-Integration" {
  source = "./modules/azure_resource_group"
  rgname   = "Rg-Integration"
  location = "eastus"
}

module "Rg-Production" {
  source = "./modules/azure_resource_group"
  rgname   = "Rg-Production"
  location = "eastus"
}


module "vnet-dev"{
  source = "./modules/azure_vnet"
  rgname = "Rg-Dev"
  location = "eastus"
  vnetname = "vnet-dev"
  subnetname = "subnet-dev"
  address_space = [ "value" ]
  address_prefixes = [ "10.9.0.0/17","10.10.0.0/17","10.11.0.0/17" ]
}

module "vnet-Integration"{
  source = "./modules/azure_vnet"
  rgname = "Rg-Integration"
  location = "eastus"
  vnetname = "vnet-Integration"
  subnetname = "subnet-Integration"
  address_space = [ "value" ]
  address_prefixes = [ "10.0.0.0/17","10.1.0.0/17","10.2.0.0/17" ]
}

module "vnet-Production"{
  source = "./modules/azure_vnet"
  rgname = "Rg-Production"
  location = "eastus"
  vnetname = "vnet-Production"
  subnetname = "subnet-Production"
  address_space = [ "value" ]
  address_prefixes = [ "10.6.0.0/17","10.7.0.0/17","10.8.0.0/17" ]
}


module "aks-dev"{
  source = "./modules/azure_aks"
  rgname = "Rg-Dev"
  vnetname = "vnet-dev"
  location = "eastus"
  aksname = "aks-dev"
  default_node_pool_name            = ""
  default_node_pool_node_count      = ""
  default_node_pool_vm_size         = ""
  default_node_pool_os_disk_size_gb = ""
  subnet_id = module.vnet-dev.vnet_subnet_id
}

module "aks-Integration"{
  source = "./modules/azure_aks"
  rgname = "Rg-Integration"
  vnetname = "vnet-Integration"
  location = "eastus"
  aksname = "aks-Integration"
  default_node_pool_name            = ""
  default_node_pool_node_count      = ""
  default_node_pool_vm_size         = ""
  default_node_pool_os_disk_size_gb = ""
  subnet_id = module.vnet-Integration.vnet_subnet_id
}

module "aks-Production"{
  source = "./modules/azure_aks"
  rgname = "Rg-Production"
  vnetname = "vnet-Production"
  location = "eastus"
  aksname = "aks-Production"
  default_node_pool_name            = ""
  default_node_pool_node_count      = ""
  default_node_pool_vm_size         = ""
  default_node_pool_os_disk_size_gb = ""
  subnet_id = module.vnet-Production.vnet_subnet_id
  node_pools = [
    {
      name            = "gpu-pool"
      node_count      = 3
      vm_size         = "Standard_NC6"
      vnet_subnet_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
      os_disk_size_gb = 128
    },
    {
      name            = "high-cpu-pool"
      node_count      = 5
      vm_size         = "Standard_D4s_v3"
      vnet_subnet_id  = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
      os_disk_size_gb = 64
    }
  ]
}

module "storage" {
  source = "./modules/azure_storage"
  rgname = "Rg-Dev"
  location = "eastus"
  storagename = "test"
  accounttype = "Standard"
  replicationtype = "LRS"
}

module "postgresql_server" {
  source              = "./modules/azure_postgresql_server"
  resource_group_name = "Rg-Dev"
  location            = "eastus"
  server_name         = ""
  sku_name            = ""
  storage_mb          = ""

  administrator_login          = ""
  administrator_login_password = ""
}

# module "ad_user1" {
#   source             = "./azure_aduser"
#   user_principal_name = "user1@yourdomain.com"
#   display_name       = "User One"
#   mail_nickname      = "user1"
#   password           = "P@ssw0rd!"
# }

# module "role_assignment_1" {
#   source = "./modules/azure_azurerm_role_definition"

#   role_scope            = "/subscriptions/<sub_id>/resourceGroups/<rg_name>"
#   principal_id          = ["<principal_id_1>"]
#   role_definition_name  = "Contributor"
# }