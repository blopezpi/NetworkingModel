
data "azurerm_virtual_network" "vnet_hub" {
name                = var.vnet_name_hub
resource_group_name = var.rg_name
}
data "azurerm_virtual_network" "vnet_spoke" {
name                = var.vnet_name_spoke
resource_group_name = var.rg_name
}

resource "azurerm_virtual_network_peering" "vnethub-vnetspoke" {
  name                      = "peering-${data.azurerm_virtual_network.vnet_hub.name}-to-${data.azurerm_virtual_network.vnet_spoke.name}"
  resource_group_name       = var.rg_name
  virtual_network_name      = data.azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_spoke.id
}
resource "azurerm_virtual_network_peering" "vnetspoke-vnethub" {
  name                      = "peering-${data.azurerm_virtual_network.vnet_spoke.name}-to-${data.azurerm_virtual_network.vnet_hub.name}"
  resource_group_name       = var.rg_name
  virtual_network_name      = data.azurerm_virtual_network.vnet_spoke.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnet_hub.id
}