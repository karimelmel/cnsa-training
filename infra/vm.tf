variable "resource_group_name" {
  type    = string
}

resource "random_string" "append_random_chars" {
  length  = 7
  upper   = false
  numeric = false
  lower   = true
  special = false
}


variable "vm_password" {
  description = "Password for Virtual Machine"
  type        = string
  sensitive   = true
}


resource "azurerm_windows_virtual_machine" "res-1" {
  admin_password        = var.vm_password
  admin_username        = "cnsaadmusr"
  location              = "westeurope"
  name                  = "cnsavm1"
  network_interface_ids = [azurerm_network_interface.res-4.id]
  resource_group_name   = var.resource_group_name
  size                  = "Standard_D2s_v5"
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-4,
  ]
}

resource "azurerm_network_interface" "res-4" {
  location            = "westeurope"
  name                = "cnsaNIC"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.res-7.id
    subnet_id                     = azurerm_subnet.res-9.id
  }
  depends_on = [
    azurerm_public_ip.res-7
  ]
}
resource "azurerm_network_security_group" "res-5" {
  location            = "westeurope"
  name                = "default-NSG"
  resource_group_name = var.resource_group_name
}
resource "azurerm_network_security_rule" "res-6" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "default-allow-3389"
  network_security_group_name = "default-NSG"
  priority                    = 1000
  protocol                    = "Tcp"
  resource_group_name         = var.resource_group_name
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_public_ip" "res-7" {
  allocation_method   = "Dynamic"
  domain_name_label   = "cnsavm1-${random_string.append_random_chars.result}"
  location            = "westeurope"
  name                = "cnsapip"
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "res-8" {
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  name                = "cnsa-VNET"
  resource_group_name = var.resource_group_name
}
resource "azurerm_subnet" "res-9" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "Subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = "cnsa-VNET"
  depends_on = [
    azurerm_virtual_network.res-8,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-10" {
  network_security_group_id = azurerm_network_security_group.res-5.id
  subnet_id                 = azurerm_subnet.res-9.id
  depends_on = [
    azurerm_network_security_group.res-5,
    azurerm_subnet.res-9,
  ]
}

output "vm_name" {
  value = resource.azurerm_windows_virtual_machine.res-1.id
  }