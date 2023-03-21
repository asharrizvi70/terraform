resource "azurerm_role_definition" "built_in_role" {
  name        = var.role_definition_name
  scope       = var.role_scope
}

resource "azurerm_role_assignment" "built_in_role_assignment" {
  count              = length(var.principal_id)
  scope              = var.role_scope
  role_definition_id = azurerm_role_definition.built_in_role.id
  principal_id       = element(var.principal_id, count.index)
}