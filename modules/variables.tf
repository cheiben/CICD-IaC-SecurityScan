variable "location" {
  description = "Azure location"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "rg-secure-demo"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "vnet-secure-demo"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
  default     = "subnet-public-demo"
}

variable "public_subnet_address_prefixes" {
  description = "Address prefixes for the public subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
  default     = "subnet-private-demo"
}

variable "private_subnet_address_prefixes" {
  description = "Address prefixes for the private subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
  default     = "nsg-secure-demo"
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
  default     = "nic-secure-demo"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "vm-secure-demo"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "public_vm" {
  description = "Set to true to deploy the VM in the public subnet (with public IP) or false for private"
  type        = bool
  default     = true
}

variable "security_center_tier" {
  description = "Security Center subscription pricing tier"
  type        = string
  default     = "Standard"
}