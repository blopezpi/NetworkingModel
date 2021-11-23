output "nsg_id" {
  value = var.nsg_id
}
output "subnet_id" {
  value = azurerm_subnet.subnet.*.id
}