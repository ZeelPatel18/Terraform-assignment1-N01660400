terraform {
  backend "azurerm" {
    resource_group_name  = "n01660400-rg"
    storage_account_name = "n01660400storage"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}