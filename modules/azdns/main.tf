resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

# resource "azurerm_dns_zone" "example-public" {
#   name                = "techypi.es"
#   resource_group_name = azurerm_resource_group.example.name
# }

resource "azurerm_private_dns_zone" "example-private" {
  name                = "techypi.cloud"
  resource_group_name = azurerm_resource_group.example.name
}