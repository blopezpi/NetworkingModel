output "vnet-id" {
    value = azurerm_virtual_network.vnet.*.id
  }

output "vnet-name" {
    value = azurerm_virtual_network.vnet.*.name
  }