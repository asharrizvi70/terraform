provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    config_context_cluster = var.cluster_name
  }
}

data "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "helm_release" "istio" {
  name       = "istio"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istio-base"
  namespace  = "istio-system"
  version    = var.istio_chart_version

  set { 
    name  = "global.mtls.enabled"
    value = "true"
  }

  set {
    name  = "global.proxy.autoInject"
    value = "enabled"
  }
}