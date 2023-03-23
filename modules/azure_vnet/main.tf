resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnetname
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = var.address_prefixes
}