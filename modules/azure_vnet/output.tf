output "vnet_subnet_id" {
  description = "ID of subnet"
  value       = azurerm_subnet.subnet.id
}

output "vnet_id" {
  description = "ID of Vnet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "name of Vnet"
  value       = azurerm_virtual_network.vnet.name
}