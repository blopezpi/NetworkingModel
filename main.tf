provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }
module "resource_groups" {
  source = "./modules/rg"
  prefix = var.prefix
  rg_name = "${var.prefix}-${var.rg_name}"
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
    source = "./modules/peerings"
    rg_name = module.resource_groups.rg-name
    vnet_name_hub = "${var.vnet_name}0"
    vnet_name_spoke = "${var.vnet_name}${count.index + 1}"
    location = var.location
#    address_space = var.address_space[count.index]
}

module "subnetshub" {
    depends_on = [module.vnets]
    source = "./modules/subnetshub"
    rg_name = module.resource_groups.rg-name
    vnet_name_hub = "${var.vnet_name}0"

}

module "azfirewall" {
    depends_on = [module.vnets]
    source = "./modules/fw"
    prefix = var.prefix
    rg_name = module.resource_groups.rg-name
    location = var.location
    subnetfw_id = module.subnetshub.subnetfw-id
    fwpip_name = var.fwpip_name
    fw_name = var.fwpip_name
    #subnet_id = module.subnetshub.subnet-id
#    address_space = var.address_space[count.index]
}

module "appgw" {
    depends_on = [module.subnetshub]
    source = "./modules/appgw"
    rg_name = module.resource_groups.rg-name
    location = var.location
    #subnetappgw_id = module.subnetshub.subnetappgw-id
    appgw_pip_name = var.appgw_pip_name
    appgw_name = var.appgw_name
    appgw_subnet_name = var.appgw_subnet_name
    vnet_name_hub = var.vnet_name_hub
    prefix = var.prefix
    #vnet_name_hub = module.vnets.vnet-name
    #subnet_id = module.subnetshub.subnet-id
#    address_space = var.address_space[count.index]
}

module "tm" {
    depends_on = [module.vnets]
    source = "./modules/tm"
    rg_name = module.resource_groups.rg-name
    tm_dns_name = var.tm_dns_name
    prefix = var.prefix
    #vnet_name_hub = "${var.vnet_name}0"

}

module "appserv" {
    depends_on = [module.vnets]
    source = "./modules/appserv"
    rg_name = module.resource_groups.rg-name
    location = var.location
    appserv = var.appserv
    appservplan = var.appservplan
    prefix = var.prefix
   # tm_dns_name = var.tm_dns_name
    #vnet_name_hub = "${var.vnet_name}0"

}

module "db" {
    depends_on = [module.vnets]
    source = "./modules/db"
    rg_name = module.resource_groups.rg-name
    prefix = var.prefix
    location = var.location
    #vnet_name_hub = "${var.vnet_name}0"

}