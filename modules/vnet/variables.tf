variable "vnet_name" {
  default = ""
}

variable "address_space" {
  description = "The address space that is used by the network."
  default     = [""]
}
variable "location" {
  default= ""
}
variable "rg_name" {
  default= ""
}
variable "prefix" {
  default= ""
}
