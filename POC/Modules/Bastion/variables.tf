variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "pip_name" {
  type = string
  default = "pip_bastion"
}

variable "bastion_name" {
  type = string
  default = "bastion"
}

variable "snet_id" {
  type = string
}

