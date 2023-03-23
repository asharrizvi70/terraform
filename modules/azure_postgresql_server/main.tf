resource "azurerm_postgresql_server" "postgresql_server" {
  name                = var.server_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  storage_mb          = var.storage_mb
  ssl_enforcement_enabled          = true
  version    = "11"
  
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}

output "postgresql_server_fqdn" {
  value = azurerm_postgresql_server.postgresql_server.fqdn
}