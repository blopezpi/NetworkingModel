provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }
module "resource_groups" {
  source = "./modules/rg"
  rg_name = var.resource_group_name
  location = var.location

module "vnets" {
    source = "./modules/vnet"
    rg_name = var.resource_group_name
    vnet_name = var.virtual_network_name
    address_space = var.settings.address_space
    location = var.location
}

}


