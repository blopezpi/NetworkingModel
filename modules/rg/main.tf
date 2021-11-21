provider "azurerm" {
      #version = "~> 2.81.0"
      features {
      }
    }
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location

}