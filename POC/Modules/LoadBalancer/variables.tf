variable "pip_name" {
    type = string
}

variable "lb_name" {
    type = string
}

variable "location" {
    type = string
}

variable "rg_name" {
    type = string
}

variable "subnet_id"{
    type = string
}

variable "lb_ip" {
    type = string
}

variable "backend_addresses" {
    type = set(string)
}

variable "vnet_id" {
    type = string
}