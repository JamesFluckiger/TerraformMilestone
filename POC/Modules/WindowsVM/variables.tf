variable "nic_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "ip_config_name" {
  type    = string
  default = "internal"
}

variable "private_ip_address" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "size" {
  type    = string
  default = "Standard_F2"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "storage_account_type" {
  description = "Storage account for the OS disk. e.g. Standard_LRS"
  type        = string
}

variable "as_id" {
  type = string
  default = null
}