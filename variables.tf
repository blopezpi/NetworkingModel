variable "rg_name" {
default = "rg_tkt_project"
}
variable "location" {
default = "westeurope"
}

variable "address_space" {
  type          = list
  description   = "The address space that is used by the network."
  default       = ["172.20.0.0/16", "172.21.0.0/16", "172.22.0.0/16"]
}
variable "vnet_name" {
default = "vnet"
}

variable "fwpip_name" {
default = "tkt-azfw-pip01"
}

variable "fw_name" {
default = "tkt-azfw-01"
}

variable "appgw_pip_name" {
    default = "tkt-appgw-pip-01"
}
variable "appgw_name" {
default = "tkt-appgw-01"
}
variable "appgw_subnet_name" {
default = "ApplicationGatewaySubnet"
}

variable "vnet_name_hub" {
default = "vnet0"
}

