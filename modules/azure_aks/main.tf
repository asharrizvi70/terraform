resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aksname
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "myaks"
  kubernetes_version  = "1.22.1"
  node_resource_group = "aks-node-rg"
  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = "dev"
  }
  default_node_pool {
    name            = var.default_node_pool_name
    node_count      = var.default_node_pool_node_count
    vm_size         = var.default_node_pool_vm_size
    vnet_subnet_id  = var.subnet_id
    os_disk_size_gb = var.default_node_pool_os_disk_size_gb
  }
  # dynamic "node_pool" {
  #   for_each = var.node_pools

  #   content {
  #     name            = node_pool.value.name
  #     node_count      = node_pool.value.node_count
  #     vm_size         = node_pool.value.vm_size
  #     vnet_subnet_id  = node_pool.value.vnet_subnet_id
  #     os_disk_size_gb = node_pool.value.os_disk_size_gb
  #   }
  # }
}