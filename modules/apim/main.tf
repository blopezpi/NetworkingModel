resource "azurerm_api_management" "apim" {
  name                = "${var.prefix}-apim"
  location            = var.location
  resource_group_name = var.rsg_name
  publisher_name      = "${var.prefix}-company"
  publisher_email     = var.publisher_email

  sku_name = "Developer_1"
}