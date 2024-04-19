locals {
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Zeel.Patel"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "resource_groups" {
  source            = "./modules/resource_group-n01660400"
  
  resource_group    = "n01660400-rg"
  location          = "eastus"
  tags              = local.tags
}

module "network" {
  source                     = "./modules/network-n01660400"
  
  location                   = module.resource_groups.location
  resource_group             = module.resource_groups.resource_group
  VNET                       = "n01660400-VNET"
  SUBNET                     = "n01660400-SUBNET"
  NSG                        = "n01660400-NSG"
  tags                       = local.tags
}

module "common" {
  source              = "./modules/common-n01660400"

  location            = module.resource_groups.location
  resource_group      = module.resource_groups.resource_group
  storage_account         = "n01660400storage"
  recovery-vault        = "n01660400-recovery-vault"
  log-workspace         ="n01660400-log-workspace"
  tags                = local.tags
}

module "linux_vm" {
  source                             = "./modules/vmlinux-n01660400"

  location                           = module.resource_groups.location
  resource_group                     = module.resource_groups.resource_group
  vm_count                           = 3
  vm_name                            = "vm-n01660400"
  subnet_id                          = module.network.subnet_id
  vm_size                            = "Standard_B1s"
  vm_boot_diag_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  vmlinux_key_path                   = "~/.ssh/id_rsa.pub"
  vmlinux_priv_key_path              = "~/.ssh/id_rsa"
  log_analytics_workspace_id         = module.common.log_workspace_id
  log_analytics_workspace_key        = module.common.log_workspace_key
  tags                               = local.tags
}

module "windows_vm" {
  source                             = "./modules/vmwindows-n01660400"

  location                           = module.resource_groups.location
  resource_group                     = module.resource_groups.resource_group
  vm_count                           = 1
  vm_name                            = "wvm-n01660400"
  subnet_id                          = module.network.subnet_id
  vm_size                            = "Standard_B1s"
  admin_username                     = "Japan"
  admin_password                     = "Admin1234"
  vm_boot_diag_primary_blob_endpoint = module.common.storage_account_primary_blob_endpoint
  log_analytics_workspace_id         = module.common.log_workspace_id
  log_analytics_workspace_key        = module.common.log_workspace_key
  tags                               = local.tags
}

module "data_disk" {
  source              = "./modules/datadisk-n01660400"

  disk_count          = 4
  disk_size_gb        = 10
  location            = module.resource_groups.location
  resource_group      = module.resource_groups.resource_group
  vm_ids              = concat(module.linux_vm.vm_ids, module.windows_vm.vm_ids)
  tags                = local.tags
}

module "loadbalancer" {
  source              = "./modules/loadbalancer-n01660400"

  location            = module.resource_groups.location
  resource_group      = module.resource_groups.resource_group
  nic_id              = module.linux_vm.nic_ids
  ip_config           = module.linux_vm.ip_config_ids
  tags                = local.tags
}

module "database" {
  source              = "./modules/database-n01660400"

  location            = module.resource_groups.location
  resource_group      = module.resource_groups.resource_group
  tags                = local.tags
}