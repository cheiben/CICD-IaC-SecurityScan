variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for compute resources"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the NIC will be attached"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to the SSH public key"
  type        = string
}

variable "public_vm" {
  description = "Set to true to deploy the VM with a public IP (public subnet), or false for a private VM."
  type        = bool
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}
