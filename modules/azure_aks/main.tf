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
    vnet_subnet_id  = var.subnet_id
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = "dev"
  }
}