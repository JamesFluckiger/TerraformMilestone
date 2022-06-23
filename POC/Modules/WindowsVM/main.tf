resource "azurerm_network_interface" "nic" {

  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address

  }
  tags = { "terraform" = "true" }
}

resource "azurerm_windows_virtual_machine" "vm" {

  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = var.size # e.g. Standard_F2
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id, ]
  availability_set_id   = var.as_id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type #e.g. Standard_LRS
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = {
    "terraform" = "true"
  }
}

resource "azurerm_managed_disk" "data" {
  name                 = "${azurerm_windows_virtual_machine.vm.name}-disk1"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8

}

resource "azurerm_virtual_machine_data_disk_attachment" "attachment" {
  managed_disk_id    = azurerm_managed_disk.data.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = "10"
  caching            = "None"

}

