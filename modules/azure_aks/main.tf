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
  addon_profile {
    aci_connector_linux {
      enabled = false
    }
    azure_policy {
      enabled = false
    }
    http_application_routing {
      enabled = false
    }
    kube_dashboard {
      enabled = false
    }
    oms_agent {
      enabled = false
    }
  }
  service_principal {
    client_id     = "my-client-id"
    client_secret = "my-client-secret"
  }
  tags = {
    environment = "dev"
  }
}