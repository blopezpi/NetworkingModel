
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

# resource "azurerm_virtual_network_peering" "vnet0-vnet2" {
#   name                      = "peering-vnet0-to-vnet2"
#   resource_group_name       = var.rg_name
#   virtual_network_name      = data.azurerm_virtual_network.vnet0.name
#   remote_virtual_network_id = data.azurerm_virtual_network.vnet2.id
# }
# resource "azurerm_virtual_network_peering" "vnet2-vnet0" {
#   name                      = "peering-vnet2-to-vnet0"
#   resource_group_name       = var.rg_name
#   virtual_network_name      = data.azurerm_virtual_network.vnet2.name
#   remote_virtual_network_id = data.azurerm_virtual_network.vnet0.id

# }

# resource "azurerm_virtual_network_peering" "vnet0-vnet1" {
#   name                      = "peering-vnet0-to-vnet1"
#   resource_group_name       = azurerm_resource_group.rg.rg_name
#   virtual_network_name      = azurerm_virtual_network.vnet[0].vnet_name
#   remote_virtual_network_id = azurerm_virtual_network.vnet[1].id
# }
# resource "azurerm_virtual_network_peering" "vnet1-vnet0" {
#   name                      = "peering-vnet1-to-vnet0"
#   resource_group_name       = azurerm_resource_group.rg.rg_name
#   virtual_network_name      = azurerm_virtual_network.vnet[1].vnet_name
#   remote_virtual_network_id = azurerm_virtual_network.vnet[0].id
# }
# resource "azurerm_virtual_network_peering" "vnet0-vnet2" {
#   name                      = "peering-vnet0-to-vnet2"
#   resource_group_name       = azurerm_resource_group.rg.rg_name
#   virtual_network_name      = azurerm_virtual_network.vnet[0].vnet_name
#   remote_virtual_network_id = azurerm_virtual_network.vnet[2].id
# }

# resource "azurerm_virtual_network_peering" "vnet2-vnet0" {
#   name                      = "peering-vnet2-to-vnet0"
#   resource_group_name       = azurerm_resource_group.rg.rg_name
#   virtual_network_name      = azurerm_virtual_network.vnet[2].vnet_name
#   remote_virtual_network_id = azurerm_virtual_network.vnet[0].id
# }