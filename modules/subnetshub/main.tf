data azurerm_virtual_network "vnethub" {
  name                = var.vnet_name_hub
  resource_group_name = var.rg_name
}
  resource "azurerm_subnet" "subnetappgw" {
  depends_on = [
    data.azurerm_virtual_network.vnethub
  ]
  name                  = "ApplicationGatewaySubnet"
  resource_group_name   = var.rg_name
  virtual_network_name  = "vnet0"
  #address_prefixes      = var.address_space
  address_prefixes      =  [cidrsubnet("${data.azurerm_virtual_network.vnethub.address_space[0]}",8,10)]
  }
   
  resource "azurerm_subnet" "subnetfw" {
  depends_on = [
    data.azurerm_virtual_network.vnethub
  ]
  name                  = "AzureFirewallSubnet"
  resource_group_name   = var.rg_name
  virtual_network_name  = "vnet0"
  address_prefixes      =  [cidrsubnet("${data.azurerm_virtual_network.vnethub.address_space[0]}",8,20)]
  }
