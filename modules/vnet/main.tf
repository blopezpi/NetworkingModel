resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.address_space]

  }
  
  resource "azurerm_subnet" "subnets" {
  depends_on = [
    azurerm_virtual_network.vnet
  ]
  count                 = 2
  name                  = "subnet${count.index + 1}-${var.vnet_name}"
  resource_group_name   = var.rg_name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  #address_prefixes      = var.address_space
  address_prefixes      =  [cidrsubnet("${azurerm_virtual_network.vnet.address_space[0]}",8,(count.index + 1))]
  }