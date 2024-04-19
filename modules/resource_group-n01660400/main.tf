resource "azurerm_resource_group" "rg_name" {
  name     = var.resource_group
  location = var.location
  tags     = var.tags
}