resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = ["10.0.1.0/24"]
}