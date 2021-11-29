data "azurerm_subnet" "subnet1-vnet1" {
  name = "subnet1-vnet1"             
  virtual_network_name = "vnet1"
  resource_group_name = var.rg_name
}
data "azurerm_subnet" "subnet1-vnet2" {
  name = "subnet1-vnet2"             
  virtual_network_name = "vnet2"
  resource_group_name = var.rg_name
}

resource "azurerm_network_interface" "nicvm1" {

  name                = "nicvm1"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet1-vnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nicvm2" {

  name                = "nicvm2"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet1-vnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  depends_on = [azurerm_network_interface.nicvm1]
  name                = "vm-vnet1"
  location            = var.location
  resource_group_name = var.rg_name
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "4-v3ry-53cr37-p455w0rd"
  network_interface_ids = [
    azurerm_network_interface.nicvm1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "vm2" {
depends_on = [azurerm_network_interface.nicvm2]
  name                = "vm-vnet2"
  location            = var.location
  resource_group_name = var.rg_name
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "4-v3ry-53cr37-p455w0rd"
  network_interface_ids = [
    azurerm_network_interface.nicvm2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}