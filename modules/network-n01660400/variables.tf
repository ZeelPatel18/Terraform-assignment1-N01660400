variable "location" {
    type = string
}

variable "resource_group" {
    type = string
}

variable "VNET" {
    type = string
    default = "n01660400-VNET"
}

variable "SUBNET" {
  type = string
  default = "n01660400-SUBNET"
}

variable "NSG" {
  type = string
  default = "n01660400-NSG"
}

variable "address_space" {
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_space" {
  default     = ["10.0.1.0/24"]
}

variable "tags" {
}