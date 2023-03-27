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
  rgname = module.Rg-Dev.resource_group_name
  location = "eastus"
  vnetname = "vnet-dev"
  address_space = [ "10.8.0.0/14" ]
  subnets = {
    "subnet1-dev" = "10.9.0.0/17"
    "subnet2-dev" = "10.10.0.0/17"
    "subnet3-dev" = "10.11.0.0/17"
  }
}

module "vnet-Integration"{
  source = "./modules/azure_vnet"
  rgname = module.Rg-Integration.resource_group_name
  location = "eastus"
  vnetname = "vnet-Integration"
  address_space = [ "10.0.0.0/14" ]
  subnets = {
    "subnet1-integration" = "10.0.0.0/17"
    "subnet2-integration" = "10.1.0.0/17"
    "subnet3-integration" = "10.2.0.0/17"
  }
}

module "vnet-Production"{
  source = "./modules/azure_vnet"
  rgname = module.Rg-Production.resource_group_name
  location = "eastus"
  vnetname = "vnet-Production"
  address_space = [ "10.4.0.0/14" ]
  subnets = {
    "subnet1-production" = "10.4.0.0/17"
    "subnet2-production" = "10.5.0.0/17"
    "subnet3-production" = "10.6.0.0/17"
  }
}


module "aks-dev"{
  source = "./modules/azure_aks"
  rgname = module.Rg-Dev.resource_group_name
  vnetname = module.vnet-dev.vnet_name
  location = "eastus"
  aksname = "development"
  subnet_id = lookup(module.vnet-dev.subnet_ids, "subnet1-dev")
}

module "aks-Integration"{
  source = "./modules/azure_aks"
  rgname = module.Rg-Integration.resource_group_name
  vnetname = module.vnet-Integration.vnet_name
  location = "eastus"
  aksname = "integration"
  default_node_pool_name            = "default-node-pool"
  default_node_pool_node_count      = 3
  default_node_pool_vm_size         = "Standard_D4s_v3"
  default_node_pool_os_disk_size_gb = 50
  subnet_id = lookup(module.vnet-Integration.subnet_ids, "subnet1-integration")
}

module "aks-Production"{
  source = "./modules/azure_aks"
  rgname = module.Rg-Production.resource_group_name
  vnetname = module.vnet-Production.vnet_name
  location = "eastus"
  aksname = "production"
  default_node_pool_name            = "default-node-pool"
  default_node_pool_node_count      = 2
  default_node_pool_vm_size         = "Standard_D4s_v3"
  default_node_pool_os_disk_size_gb = 50
  subnet_id = lookup(module.vnet-Production.subnet_ids, "subnet1-production")
  additional_node_pools = [
    {
      name            = "nap-e2-standard"
      node_count      = 3
      vm_size         = "Standard_D2s_v3"
      vnet_subnet_id  = lookup(module.vnet-Production.subnet_ids, "subnet1-production")
      os_disk_size_gb = 128
    }
  ]
}

module "storage" {
  source = "./modules/azure_storage"
  rgname = module.Rg-Dev.resource_group_name
  location = "eastus"
  storage_account_names = [
    "temppublicshare",
    "prodmetabobartifacts",
    "metabobmigrationtemp",
    "metabobintrnldatastore",
    "devmetabobusmlartifacts",
    "artifactsmetabobapps"
  ]
  accounttype = "Standard"
  replicationtype = "LRS"
}

module "postgresql_server-dev" {
  source              = "./modules/azure_postgresql_server"
  resource_group_name = module.Rg-Dev.resource_group_name
  location            = "eastus"
  server_name         = "postgresql-server-dev"
  storage_mb          = 5120
  sku_name            = "GP_Gen5_2"
  administrator_login          = "dbadmin"
  administrator_login_password = "f1TTh4vs&F2SPH6q3l"
}

module "postgresql_server-Integration" {
  source              = "./modules/azure_postgresql_server"
  resource_group_name = module.Rg-Integration.resource_group_name
  location            = "eastus"
  server_name         = "postgresql-server-integration"
  storage_mb          = 5120
  sku_name            = "GP_Gen5_2"
  administrator_login          = "dbadmin"
  administrator_login_password = "%M6dXUZ5sU1N872wdW"
}

module "postgresql_server-production" {
  source              = "./modules/azure_postgresql_server"
  resource_group_name = module.Rg-Production.resource_group_name
  location            = "eastus"
  server_name         = "postgresql-server-production"
  storage_mb          = 5120
  sku_name            = "GP_Gen5_2"
  administrator_login          = "dbadmin"
  administrator_login_password = "8Nb2IDf*9Uj&k4nXlH"
}

module "azuread_users" {
  source = "./azuread_user"

  users = [
    {
      username = "user1"
      password = "P@ssw0rd123"
      display_name = "User One"
      mail_nickname = "user1"
      user_principal_name = "user1@mydomain.com"
    },
    {
      username = "user2"
      password = "P@ssw0rd456"
      display_name = "User Two"
      mail_nickname = "user2"
      user_principal_name = "user2@mydomain.com"
    },
    {
      username = "user3"
      password = "P@ssw0rd789"
      display_name = "User Three"
      mail_nickname = "user3"
      user_principal_name = "user3@mydomain.com"
    },
  ]
}

# module "role_assignment_1" {
#   source = "./modules/azure_azurerm_role_definition"

#   role_scope            = "/subscriptions/<sub_id>/resourceGroups/<rg_name>"
#   principal_id          = ["<principal_id_1>"]
#   role_definition_name  = "Contributor"
# }