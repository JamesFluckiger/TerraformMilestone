

resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  tags = {
    "terraform" = true
  }
}



resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  frontend_ip_configuration {
    name = "PrivateIPAddress"

    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = var.lb_ip
    //availability_zone = "No-Zone"
  }
  tags = {
    "terraform" = "true"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "lb_pool_address" {
  for_each = var.backend_addresses

  name                    = "${each.value}-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
  virtual_network_id      = var.vnet_id
  ip_address              = each.value
}

resource "azurerm_lb_rule" "rule80" {
  //resource_group_name            = azurerm_lb.lb.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PrivateIPAddress"
}

resource "azurerm_lb_rule" "rule443" {
  //resource_group_name            = azurerm_lb.lb.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "LBRule443"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "PrivateIPAddress"
}

resource "azurerm_lb_probe" "probe80" {
  //resource_group_name = azurerm_lb.lb.resource_group_name
  loadbalancer_id = azurerm_lb.lb.id
  name            = "80-running-probe"
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_probe" "probe443" {
  //resource_group_name = azurerm_lb.lb.resource_group_name
  loadbalancer_id = azurerm_lb.lb.id
  name            = "443-running-probe"
  protocol        = "Tcp"
  port            = 443
}
