resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet.address_space
#  tags                = local.tags

#   dns_servers = coalesce(
#     try(lookup(var.settings.vnet, "dns_servers", null)),
#     try(local.dns_servers_process, null)
#   )

#   dynamic "ddos_protection_plan" {
#     for_each = var.ddos_id != "" ? [1] : []

#     content {
#       id     = var.ddos_id
#       enable = true
#     }
#   }

}