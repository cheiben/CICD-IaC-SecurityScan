terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source                          = "./modules/network"
  resource_group_name             = module.resource_group.name
  location                        = module.resource_group.location
  vnet_name                       = var.vnet_name
  vnet_address_space              = var.vnet_address_space
  public_subnet_name              = var.public_subnet_name
  public_subnet_address_prefixes  = var.public_subnet_address_prefixes
  private_subnet_name             = var.private_subnet_name
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  nsg_name                        = var.nsg_name
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = var.public_vm ? module.network.public_subnet_id : module.network.private_subnet_id # Choose the subnet ID based on whether the VM is public or private.
  nic_name            = var.nic_name
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  public_vm           = var.public_vm
}

module "security_center" {
  source = "./modules/security_center"
  tier   = var.security_center_tier
}

//optional but good to expose some ouptfrom module
output "resource_group" {
  value = module.resource_group.name
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "private_subnet_id" {
  value = module.network.private_subnet_id
}

output "vm_id" {
  value = module.compute.vm_id
}
