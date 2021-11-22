resource "azurerm_resource_group" "rg" {
  name                = var.rg_name
  location            = var.location
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