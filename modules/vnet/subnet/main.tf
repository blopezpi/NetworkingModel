resource "null_resource" "module_depends_on" {
  triggers = {
    value = length(var.module_depends_on)
  }
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.rsg_name
  depends_on          = [null_resource.module_depends_on]
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = var.rsg_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefix       = var.subnets[count.index].cidr_block
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  count                     = length(var.subnets)
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = var.nsg_id
}