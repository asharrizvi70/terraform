output "object_id" {
  value = azuread_user.user.object_id
}

output "user_principal_name" {
  value = azuread_user.user.user_principal_name
}

output "display_name" {
  value = azuread_user.user.display_name
}

output "mail_nickname" {
  value = azuread_user.user.mail_nickname
}
