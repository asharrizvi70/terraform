variable "resource_group_name" {
  type = string
}

variable "server_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "GP_Gen5_2"
}

variable "storage_mb" {
  type    = number
  default = 5120
}

variable "administrator_login" {
  type = string
}

variable "administrator_login_password" {
  type = string
}