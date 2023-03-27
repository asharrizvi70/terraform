output "user_ids" {
  value = [for user in azuread_user.users : user.object_id]
}