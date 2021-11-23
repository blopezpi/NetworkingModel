variable "subnets" {
  default = [
    {
      name       = ""
      cidr_block = ""
    }
  ]
}
variable "vnet_name" {
}
variable "rsg_name" {
}
variable "nsg_id" {
}
variable "module_depends_on" {
  default = [""]
}