resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_subnet" "subnet" {
  name                 = "aks-subnet"
  resource_group_name  = var.rgname
  virtual_network_name = var.vnetname
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "myaks"
  kubernetes_version  = "1.22.1"
  node_resource_group = "aks-node-rg"
  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B2s"
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = "dev"
  }
}