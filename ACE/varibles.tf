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


variable "snet_web_name" {
  type = string
  default = null
}

variable "snet_web_address_space" {
  type = list(string)
  default = null
}

variable "snet_gateway_address_space" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}
variable "lb_ip" {
  type = string
}

variable "vm_username" {
  description = "The username for the VMs."
  type = string
  sensitive = true
}
variable "vm_password" {
  description = "The password for the VMs."
  type = string
  sensitive = true
}

variable "web1_ip" {
  type = string
}

variable "web2_ip" {
  type = string
}

variable "dc1_ip" {
  type = string
}

variable "dc2_ip" {
  type = string
}

