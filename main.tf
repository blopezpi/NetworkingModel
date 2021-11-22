provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }
module "resource_groups" {
  source = "./modules/rg"
  rg_name = var.resource_group_name
  location = var.location
}

module "vnets" {
    count = length(var.address_space)
    source = "./modules/vnet"
    rg_name = module.resource_groups.rg_name
    vnet_name = var.virtual_network_name
    location = var.location
    address_space = var.address_space[count.index]




