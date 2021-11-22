variable "rg_name {
default = ""
}
variable "location" {
default = ""
}

variable "address_space" {
  type = list
  description = "The address space that is used by the network."
  default = ""
}