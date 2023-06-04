variable "resource_group_name" {
  type    = string
  default = "cn-training"
}

resource "random_string" "storage_account_name" {
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
    # One of azurerm_subnet.res-9,azurerm_subnet_network_security_group_association.res-10 (can't auto-resolve as their ids are identical)
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
  domain_name_label   = "cnsavm1-${random_string.storage_account_name.result}"
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

/*

FJERNES I FØRSTE LAB 


resource "azurerm_virtual_machine_extension" "res-3" {
  auto_upgrade_minor_version = true
  name                       = "InvokeHardening"
  publisher                  = "Microsoft.Compute"
  settings                   = "{\"commandToExecute\":\"powershell.exe -ExecutionPolicy Bypass -File Invoke-Hardening.ps1\",\"fileUris\":[\"https://gist.githubusercontent.com/karimelmel/9897d373502ccaed22ac3722aa13b878/raw/a68bc0d8dbad022980857106d0df8eaf64e561e6/Invoke-Hardening.ps1\"],\"managedIdentity\":{}}"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  virtual_machine_id         = azurerm_windows_virtual_machine.res-1.id
  depends_on = [
    azurerm_windows_virtual_machine.res-1,
  ]
}


*/





/*

FJERNES IKKE FØR SENERE LABBER

resource "azurerm_storage_account" "res-13" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = "westeurope"
  min_tls_version          = "TLS1_0"
  name                     = "cnsa${random_string.storage_account_name.result}"
  resource_group_name      = var.resource_group_name
  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_storage_container" "res-15" {
  name                 = "artifacts"
  storage_account_name = azurerm_storage_account.res-13.name
  depends_on = [ 
    azurerm_storage_account.res-13,
   ]
}


resource "azurerm_role_assignment" "res-16" {
  scope                = azurerm_storage_account.res-13.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_windows_virtual_machine.res-1.identity.0.principal_id
    depends_on = [
    azurerm_storage_account.res-13,
  ]
}
*/
