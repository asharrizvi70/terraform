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

variable "address_space" {
  type = list(string)
}

variable "address_prefixes" {
  type = list(string)
}