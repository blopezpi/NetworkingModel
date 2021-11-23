provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }
module "resource_groups" {
  source = "./modules/rg"
  rg_name = var.rg_name
  location = var.location
}

module "vnets" {
    count = length(var.address_space)
    depends_on = [module.resource_groups]
    source = "./modules/vnet"
    rg_name = module.resource_groups.rg-name
    vnet_name = "${var.vnet_name}${count.index}"
    location = var.location
    address_space = var.address_space[count.index]
}

module "peerings" {
    count = 2
    depends_on = [module.vnets]
    source = "./modules/vnet/peerings"
    rg_name = module.resource_groups.rg-name
    vnet_name = "${var.vnet_name}${count.index}"
    location = var.location
    address_space = var.address_space[count.index]
}