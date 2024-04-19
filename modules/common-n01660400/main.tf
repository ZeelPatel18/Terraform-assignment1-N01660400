resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = var.log-workspace
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "recovery_vault" {
  name                = var.recovery-vault
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  soft_delete_enabled = true
  tags                = var.tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account
  location                 = var.location
  resource_group_name      = var.resource_group
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}