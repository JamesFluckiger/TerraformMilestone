# terraform {
#   cloud {
#     organization = "jamesafluke1"

#     workspaces {
#       name = "Terraform_Module_ACE_workspace"
#     }
#   }
# }


terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}


provider "azurerm" {
  features {}

  # CDW sub
  subscription_id = "3c2067eb-14d4-42da-83ca-73316e5fce7a"
  tenant_id       = "c022673d-2b5c-406e-bb6a-d9e40ee64bc9"

  # Personal sub
  #   subscription_id = "74c2e3ac-be44-401a-acea-768ddd167a5f"
  #   tenant_id       = "c74940ec-9df1-429e-9e18-5ee10c445e4f"
}





resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.rg_name}-${var.env}-${var.loc}"
  location = var.location
  tags     = { "terraform" = true }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_servers

  tags = { "terraform" = true }
}

resource "azurerm_subnet" "snet_bastion" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = var.snet_bastion_name
  address_prefixes     = var.snet_bastion_address_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "snet_adds" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "snet-${var.snet_adds_name}"
  address_prefixes     = var.snet_adds_address_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "snet_web" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "snet-${var.snet_web_name}"
  address_prefixes     = var.snet_web_address_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "snet_gateway" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "GatewaySubnet"
  address_prefixes     = var.snet_gateway_address_space
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    "terraform" = true
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association1" {
  subnet_id                 = azurerm_subnet.snet_adds.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_association2" {
  subnet_id                 = azurerm_subnet.snet_web.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

module "Bastion" {
  source   = "../Modules/Bastion/"
  location = var.location
  rg_name  = azurerm_resource_group.rg.name
  snet_id  = azurerm_subnet.snet_bastion.id
}

module "vm_web1" {
  source               = "../Modules/WindowsVM"
  nic_name             = "nic_aceweb1"
  location             = var.location
  rg_name              = azurerm_resource_group.rg.name
  private_ip_address   = var.web1_ip
  subnet_id            = azurerm_subnet.snet_web.id
  vm_name              = "vmaceweb1"
  admin_username       = var.vm_username
  admin_password       = var.vm_password
  storage_account_type = "Standard_LRS"
}

module "vm_web2" {
  source               = "../Modules/WindowsVM"
  nic_name             = "nic_aceweb2"
  location             = var.location
  rg_name              = azurerm_resource_group.rg.name
  private_ip_address   = var.web2_ip
  subnet_id            = azurerm_subnet.snet_web.id
  vm_name              = "vmaceweb2"
  admin_username       = var.vm_username
  admin_password       = var.vm_password
  storage_account_type = "Standard_LRS"
}

module "lb" {
  source    = "../Modules/LoadBalancer"
  pip_name  = "pip-lb"
  lb_name   = "lb-web"
  location  = var.location
  rg_name   = azurerm_resource_group.rg.name
  subnet_id = azurerm_subnet.snet_web.id
  lb_ip     = var.lb_ip
  backend_addresses = [
    var.web1_ip,
    var.web2_ip
  ]
  vnet_id = azurerm_virtual_network.vnet.id
}

module "vm_dc1" {
  source               = "../Modules/WindowsVM"
  nic_name             = "nic_acedc1"
  location             = var.location
  rg_name              = azurerm_resource_group.rg.name
  private_ip_address   = var.dc1_ip
  subnet_id            = azurerm_subnet.snet_adds.id
  vm_name              = "vmacedc1"
  admin_username       = var.vm_username
  admin_password       = var.vm_password
  storage_account_type = "Standard_LRS"
}

module "vm_dc2" {
  source               = "../Modules/WindowsVM"
  nic_name             = "nic_acedc2"
  location             = var.location
  rg_name              = azurerm_resource_group.rg.name
  private_ip_address   = var.dc2_ip
  subnet_id            = azurerm_subnet.snet_adds.id
  vm_name              = "vmacedc2"
  admin_username       = var.vm_username
  admin_password       = var.vm_password
  storage_account_type = "Standard_LRS"
}

# resource "azurerm_resource_group" "rg_deleteme-thisisapipelinetest" {
#   name     = "rg-deleteme-thisisapipelinetest"
#   location = var.location
#   tags     = { "terraform" = true }
# }







