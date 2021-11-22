variable "rg_name" {
default = "rg_tkt_project"
}
variable "location" {
default = "westeurope"
}

variable "address_space" {
  type          = list
  description   = "The address space that is used by the network."
  default       = ["172.21.0.0/16", "172.22.0.0/16", "172.23.0.0/16"]
}
variable "vnet_name" {
default = "vnet-"
}