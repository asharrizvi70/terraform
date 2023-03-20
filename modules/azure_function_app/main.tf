resource "azurerm_function_app" "example" {
  name                       = var.appname
  location                   = var.location
  resource_group_name        = var.rgname
  app_service_plan_id        = var.aspid
}