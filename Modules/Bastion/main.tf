resource "azurerm_public_ip" "pip" {
  name = var.pip_name
  location = var.location
  resource_group_name = var.rg_name
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name = var.bastion_name
  location = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name = "configuration"
    subnet_id = var.snet_id
    public_ip_address_id = azurerm_public_ip.pip.id 
  }
}