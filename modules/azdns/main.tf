resource "azurerm_private_dns_zone" "dnsprivate" {
  name                = "${var.prefix}.tk"
  resource_group_name   = var.rg_name
}