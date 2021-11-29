resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}
resource "azurerm_traffic_manager_profile" "profile" {
  name                   = random_id.server.hex
  resource_group_name    = var.rg_name
  traffic_routing_method = "Weighted"

  dns_config {
    relative_name = random_id.server.hex
    ttl           = 30
  }

  monitor_config {
    protocol = "http"
    port     = 80
    path     = "/"
  }
}
