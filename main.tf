terraform {
  backend "azurerm" {
    storage_account_name = "examplestorage"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
    resource_group_name  = "dev-rg"
  }
}

# #provisioning resource group
# module "dev_resource_group" {
#   source = "./modules/azure_resource_group"
#   rgname   = "dev-rg"
#   location = "westindia"
# }

module "vnet"{
  source = "./modules/azure_vnet"
  rgname = "dev-rg"
  location = "westindia"
  vnetname = "dev-vnet"
  subnetname = "dev-subnet"  
}

module "asp-plan"{
  source = "./modules/azure_app_service_plan"
  rgname = "dev-rg"
  location = "westindia"
  aspname = "dcaas-dev-asp"
  skusize = "S1"
}
module "app" {
  source = "./modules/azure_app_service"
  rgname = "dev-rg"
  location = "westindia"
  appname = "dcaas-dev-app"
  aspid   = module.asp-plan.asp_id
}
module "cosmosdb" {
  source = "./modules/azure_cosmos_db"
  rgname = "dev-rg"
  location = "westindia"
  kind = "SQL"
  cosmosdb_name = "dev-qumulus-cosmosdb"
}
module "storage" {
  source = "./modules/azure_storage"
  rgname = "dev-rg"
  location = "westindia"
  storagename = "devstqumukus"
  accounttype = "Standard"
  replicationtype = "LRS"
}
module "eventgrid" {
  source = "./modules/azure_event_grid"
  rgname = "dev-rg"
  location = "westindia"
  eventgridname = "dev-eventgrid-qumulus"

}

#provisioning apim
module "dev_apim" {
  source = "./modules/azure_apim"
  rgname   = "dev-rg"
  location = "westindia"
  apimname = "dev-apim-011"
  sku      = "Developer_1"
}


module "funtionapp"{
  source = "./modules/azure_function_app"
  rgname = "dev-rg"
  location = "westindia"
  appname = "appdevqumulus"
  aspid   = module.asp-plan.asp_id
  storageaccountname = module.storage.storageaccountname
  storageaccountaccesskey = module.storage.storageaccountaccesskey
}
module "frontdoor" {
  source = "./modules/azure_front_door"
  name = "exampleFrontendEndpoint1"
  rgname = "dev-rg"
  backend_name = "exampleBackend"
  backend_hostname = "www.bing.com"
  frontend_name = "exampleFrontendEndpoint1"
  frontend_hostname = "exampleFrontendEndpoint1.azurefd.net"

}

module "aks"{
  source = "./modules/azure_aks"
  rgname = "dev-rg"
  vnetname = "dev-vnet"
  location = "westindia"
  aksname = "dev-aks"
  subnet_id = module.vnet.vnet_subnet_id
}