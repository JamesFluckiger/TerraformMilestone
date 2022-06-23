variable "location" {
  type = string
}

variable "loc" {
  type = string
}

variable "env" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "vnet_dns_servers" {
  type = list(string)
}

variable "snet_bastion_name" {
  type = string
}

variable "snet_bastion_address_space" {
  type = list(string)
}

variable "snet_adds_name" {
  type = string
}

variable "snet_adds_address_space" {
  type = list(string)
}

variable "snet_gateway_address_space" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}

variable "dc1_ip" {
  type = string
}

variable "dc2_ip" {
  type = string
}

