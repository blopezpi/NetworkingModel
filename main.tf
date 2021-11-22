provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }
module "resource_groups" {
  source = "./modules/rg"
  rg_name = var.resource_group_name
  location = var.location
<<<<<<< HEAD:main.tf

module "vnet" {
    count = length(var.address_space)
=======
}
module "vnets" {
>>>>>>> ok:modules/main.tf
    source = "./modules/vnet"
    rg_name = module.resource_groups.rg_name
    vnet_name = var.virtual_network_name
<<<<<<< HEAD:main.tf
    address_space = var.address_space[count.index]
=======
    address_space = var.address_space
>>>>>>> ok:modules/main.tf
    location = var.location
}

<<<<<<< HEAD:main.tf
}
=======
>>>>>>> ok:modules/main.tf

