
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.address_space]

  }
  
  resource "azurerm_subnet" "subnets" {
  depends_on = [
    azurerm_virtual_network.vnet
  ]
  count                 = 2
  name                  = "subnet${count.index + 1}-${var.vnet_name}"
  resource_group_name   = var.rg_name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  #address_prefixes      = var.address_space
  address_prefixes      =  [cidrsubnet("${azurerm_virtual_network.vnet.address_space[0]}",8,(count.index + 1))]
  }

resource "azurerm_network_security_group" "nsg" {
  count = 2
  #name                = "nsg-${azurerm_subnet.subnets[0]}"
  name                = "nsg-${azurerm_subnet.subnets[count.index].name}"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet_network_security_group_association" "nsgasoc" {
  count = 2
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

  # security_rule {
  #   name                       = "test123"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }


# resource "azurerm_network_security_group" "nsg2" {
#   name                = "nsg-${var.subnet-name[1]}"
#   location            = var.location
#   resource_group_name = var.rg_name

#   security_rule {
#     name                       = "test123"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

# }


