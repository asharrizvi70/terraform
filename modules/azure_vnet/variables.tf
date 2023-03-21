//------------------------------------General Properties------------------------------------\\
variable "rgname" {
  type    = string
  default = "RG-git-DEMO-LINUXVM"
}

variable "location" {
  type    = string
  default = "West US"
}

variable "vnetname" {
  type    = string
  default = ""
}

variable "subnetname" {
  type    = string
  default = ""
}