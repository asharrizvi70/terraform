resource "azurerm_app_service_plan" "asp" {
  name                = var.aspname
  location            = var.location
  resource_group_name = var.rgname

  sku {
    tier = var.skutier
    size = var.skusize
  }
}

