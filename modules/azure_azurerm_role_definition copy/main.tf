resource "azurerm_role_assignment" "role_assignments" {
  for_each = { for user in var.users : user.name => user }

  scope              = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  role_definition_id = data.azurerm_role_definition.role_definitions[each.value.role_definition_name].id
  principal_id       = each.value.principal_id

  }

data "azurerm_role_definition" "role_definitions" {
  scope = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
}

data "azurerm_subscription" "current" {}