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

resource "azurerm_route_table" "RTFW" {
  name                          = "rts-FW"
  location            = var.location
  resource_group_name = var.rg_name
  disable_bgp_route_propagation = false

  route {
    name           = "subnet1-vnet0"
    address_prefix = "172.20.1.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }

    route {
    name           = "subnet2-vnet0"
    address_prefix = "172.20.2.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }
    route {
    name           = "subnet1-vnet1"
    address_prefix = "172.21.1.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }
    route {
    name           = "subnet2-vnet1"
    address_prefix = "172.21.2.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }

      route {
    name           = "subnet1-vnet2"
    address_prefix = "172.22.1.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }

      route {
    name           = "subnet2-vnet2"
    address_prefix = "172.22.2.0/24"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.azure_firewall.ip_configuration[0].private_ip_address
  }
}