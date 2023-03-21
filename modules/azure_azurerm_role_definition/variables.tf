variable "role_scope" {
  description = "The scope at which to create the role assignment (e.g. /subscriptions/<sub_id>/resourceGroups/<rg_name>)."
}

variable "principal_id" {
  description = "The principal ID of the user, group, or service principal to assign the role to."
}

variable "role_definition_name" {
  description = "The name of the built-in role to assign (e.g. 'Contributor', 'Reader', 'Owner')."
}