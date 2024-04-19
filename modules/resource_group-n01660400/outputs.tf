output "resource_group" {
  value = azurerm_resource_group.rg_name.name
}

output "location" {
  value = azurerm_resource_group.rg_name.location
}