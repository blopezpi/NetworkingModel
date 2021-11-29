provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }

##1.RG
module "resource_groups" {
  source = "./modules/rg"
  prefix = var.prefix
  rg_name = "${var.prefix}-${var.rg_name}"
  location = var.location
}

#2. Applicación (Appservice)
module "appserv" {
    depends_on = [module.resource_groups]
    source = "./modules/appserv"
    rg_name = module.resource_groups.rg-name
    location = var.location
    appserv = var.appserv
    appservplan = var.appservplan
    prefix = var.prefix

}



##3. Base de datos y storage account
module "db" {
    depends_on = [module.resource_groups]
    source = "./modules/db"
    rg_name = module.resource_groups.rg-name
    prefix = var.prefix
    location = var.location

}



#4. Lógica de red, Vnets, subnets y NSgGs de redes spoke(infraestructua de red)
module "vnets" {
    count = length(var.address_space)
    depends_on = [module.resource_groups]
    source = "./modules/vnet"
    rg_name = module.resource_groups.rg-name
    vnet_name = "${var.vnet_name}${count.index}"
    location = var.location
    address_space = var.address_space[count.index]
}
##4.1 Subredes
module "subnetshub" {
    depends_on = [module.vnets]
    source = "./modules/subnetshub"
    rg_name = module.resource_groups.rg-name
    vnet_name_hub = "${var.vnet_name}0"
}

module "vms" {

    depends_on = [module.vnets]
    source = "./modules/vms"
    rg_name = module.resource_groups.rg-name
    location = var.location
}

# 5. Application Gateway
module "appgw" {
    depends_on = [module.subnetshub]
    source = "./modules/appgw"
    rg_name = module.resource_groups.rg-name
    location = var.location
    appgw_pip_name = var.appgw_pip_name
    appgw_name = var.appgw_name
    appgw_subnet_name = var.appgw_subnet_name
    vnet_name_hub = var.vnet_name_hub
    prefix = var.prefix

}

##5. Peerings (conectividad enre redes)
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

## 6. Azure Firewall (enrutamiento y proteccicón)
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

## 8. Traffic Manager
module "tm" {
    depends_on = [module.vnets]
    source = "./modules/tm"
    rg_name = module.resource_groups.rg-name
    tm_dns_name = var.tm_dns_name
    prefix = var.prefix
    #vnet_name_hub = "${var.vnet_name}0"

}

## 9 Azure DNS
module "azdns" {
    depends_on = [module.vnets]
    source = "./modules/azdns"
    rg_name = module.resource_groups.rg-name
    prefix = var.prefix
    location = var.location
    #vnet_name_hub = "${var.vnet_name}0"

}
## 10.API management
module "apim" {
    depends_on = [module.vnets]
    source = "./modules/apim"
    rg_name = module.resource_groups.rg-name
    prefix = var.prefix
    location = var.location
    publisher_email= var.publisher_email
    #vnet_name_hub = "${var.vnet_name}0"

}