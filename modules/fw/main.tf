# Create the public ip for Azure Firewall
resource "azurerm_public_ip" "azure_firewall_pip" {
  name = "${var.prefix}-${var.fwpip_name}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method = "Static"
  sku = "Standard"
}

# Create the Azure Firewall
resource "azurerm_firewall" "azure_firewall" {
  depends_on=[azurerm_public_ip.azure_firewall_pip]
  name = "${var.prefix}-${var.fw_name}"
  resource_group_name= var.rg_name
  location            = var.location
  ip_configuration {
    name = "hg-${var.location}-fw-config"
    subnet_id = var.subnetfw_id
    public_ip_address_id = azurerm_public_ip.azure_firewall_pip.id
  }
}