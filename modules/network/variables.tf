variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "vnet-secure-demo"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "rg-secure-demo"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "East US"
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