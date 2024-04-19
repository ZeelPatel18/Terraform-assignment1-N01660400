resource "azurerm_postgresql_server" "database" {
  name                         = "lab-db-zeel"
  location                     = var.location
  resource_group_name          = var.resource_group
  sku_name                     = "B_Gen5_1"
  administrator_login          = "azureuser"
  administrator_login_password = "Admin1234"
  version                      = "10"
  ssl_enforcement_enabled      = true
  tags                         = var.tags
}