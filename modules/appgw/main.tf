
data "azurerm_subnet" "appgw_subnet" {
name                = var.appgw_subnet_name
resource_group_name = var.rg_name
virtual_network_name = var.vnet_name_hub
}

locals {
  backend_address_pool_name      = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-beap"
  frontend_port_name             = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-feip"
  http_setting_name              = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-be-htst"
  listener_name                  = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_subnet.appgw_subnet.virtual_network_name}-rdrcfg"
}

resource "azurerm_public_ip" "appgw_pip" {
  name                = "${var.prefix}-${var.appgw_name}-pip01" #tkt-appgw-pip01
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

resource "azurerm_application_gateway" "network" {
  name                = "${var.prefix}${var.appgw_name}"
  location            = var.location
  resource_group_name = var.rg_name

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.appgw_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}