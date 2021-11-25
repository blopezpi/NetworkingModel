resource "azurerm_traffic_manager_profile" "profile" {
  name                   = "trafficmanagerprofile"
  resource_group_name = var.rg_name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = var.tm_dns_name
    ttl           = 30
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }
}

# resource "azurerm_traffic_manager_endpoint" "endpoint" {
#   name                = "endpoint${count.index}"
#   resource_group_name = var.rg_name
#   profile_name        = "${azurerm_traffic_manager_profile.profile.name}"
#   target_resource_id  = "${element(azurerm_public_ip.pip.*.id, count.index)}"
#   type                = "azureEndpoints"
#   weight              = 1
#   count               = 2
# }