//------------------------------------General Properties------------------------------------\\
variable "rgname" {
  type    = string
  default = "RG-git-DEMO-LINUXVM"
}

variable "vnetname" {
  type    = string
  default = "RG-git-DEMO-VNET"
}

variable "location" {
  type    = string
  default = "West US"
}

variable "aksname" {
  type    = string
  default = "RG-git-DEMO-AKS"
}

variable "subnet_id" {
  type    = string
  default = ""
}