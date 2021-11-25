resource "azurerm_sql_server" "sqlserver" {
  name                         = "${var.prefix}-sqlserver"
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"

}

resource "azurerm_storage_account" "sta" {
  name                     = "${var.prefix}storage"
  resource_group_name          = var.rg_name
  location                     = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_database" "sqldatabase" {
  name                = "${var.prefix}sqldatabase"
  resource_group_name = var.rg_name
  location                     = var.location
  server_name         = azurerm_sql_server.sqlserver.name

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.sta.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.sta.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }
}