variable "resource_group_name" {
  type    = string
  default = "cn-training"
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
  user_data = "IDwjCi5TWU5PUFNJUwogICAgRnVuY3Rpb24gZm9yIGRvd25sb2FkaW5nIGFuZCBleGVjdXRpbmcgSGFyZGVuaW5nS2l0dHkKICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zY2lwYWcvSGFyZGVuaW5nS2l0dHkKCi5ERVNDUklQVElPTgogICAgVHJpZ2dlcnMgdGhyZWUgZGlzdGluY3RpdmUgZnVuY3Rpb25zIGFzIGEgc2luZ2xlIGxpbmUgdG8gYXBwbHkgaGFyZGVuaW5nIGFuZCBwYXNzaW5nIHRoZSBwYXJhbWV0ZXJzLgogICAgCi5QQVJBTUVURVIgRmlsZUZpbmRpbmdMaXN0CiAgICBUaGUgcGF0aCB0byB0aGUgQ1NWIGZpbGUgZm9yIEhhcmRlbmluZ0tpdHR5IGNvbmZpZ3VyYXRpb24uCgouUEFSQU1FVEVSIEhhcmRlbmluZ0tpdHR5UGF0aAogICAgVGhlIHBhdGggdG8gd2hlcmUgSGFyZGVuaW5nS2l0dHkgbW9kdWxlIGlzIGltcG9ydGVkIGZyb20uCgouUEFSQU1FVEVSIFVuemlwUGF0aAogICAgVGhlIHBhdGggdG8gd2hlcmUgdGhlIGRvd25sb2FkZWQgZmlsZSBpcyB1bnppcHBlZCB0by4KCi5QQVJBTUVURVIgUGFja2FnZVVybAogICAgVGhlIFVSTCB0byB0aGUgemlwIHBhY2thZ2UgdG8gZG93bmxvYWQgYW5kIGV4dHJhY3QuCgouTk9URVMKICAgIEFsbCBwYXJhbWV0ZXJzIGFyZSBwYXNzZWQgaW4gdGhlIHN1cGVyLWZ1bmN0aW9uIHRvIHRoZSBjb3JyZXNwb25kaW5nIGZ1bmN0aW9ucy4gCgouRVhBTVBMRSAKICAgIEludm9rZS1IYXJkZW5pbmcKICAgIEludm9rZS1IYXJkZW5pbmcgLUZpbGVGaW5kaW5nTGlzdCA8cGF0aCB0byBjdXN0b20gZmlsZSBmaW5kaW5nIGxpc3Q+CiM+CgpmdW5jdGlvbiBJbnZva2UtSGFyZGVuaW5nIHsKICAgIFtDbWRsZXRCaW5kaW5nKCldCiAgICBwYXJhbSAoCiAgICAgICAgW1BhcmFtZXRlcihNYW5kYXRvcnkgPSAkZmFsc2UpXQogICAgICAgIFtzdHJpbmddCiAgICAgICAgJEZpbGVGaW5kaW5nTGlzdCA9IChKb2luLVBhdGggLVBhdGggJGVudjpURU1QIC1DaGlsZFBhdGggIlNlY3VyaXR5QmFzZWxpbmVcSGFyZGVuaW5nS2l0dHktdi4wLjkuMFxsaXN0c1xmaW5kaW5nX2xpc3RfMHg2ZDY5NjM2Yl9tYWNoaW5lLmNzdiIpLAogICAgICAgIFtzdHJpbmddCiAgICAgICAgJEhhcmRlbmluZ0tpdHR5UGF0aCA9ICggSm9pbi1QYXRoICRlbnY6VEVNUCAtQ2hpbGRQYXRoICJTZWN1cml0eUJhc2VsaW5lXEhhcmRlbmluZ0tpdHR5LXYuMC45LjAiICksCiAgICAgICAgW1BhcmFtZXRlcihNYW5kYXRvcnkgPSAkZmFsc2UpXQogICAgICAgIFtzdHJpbmddCiAgICAgICAgJFVuemlwUGF0aCA9ICggSm9pbi1QYXRoICRlbnY6VEVNUCAtQ2hpbGRQYXRoICJTZWN1cml0eUJhc2VsaW5lIiApLAogICAgICAgIFtQYXJhbWV0ZXIoTWFuZGF0b3J5ID0gJGZhbHNlKV0KICAgICAgICBbc3RyaW5nXQogICAgICAgICRQYWNrYWdlVXJsID0gImh0dHBzOi8vZ2l0aHViLmNvbS9zY2lwYWcvSGFyZGVuaW5nS2l0dHkvYXJjaGl2ZS9yZWZzL3RhZ3Mvdi4wLjkuMC56aXAiCiAgICApCgogICAgZnVuY3Rpb24gR2V0LVVuemlwcGVkUGFja2FnZSB7CiAgICAgICAgcGFyYW0oCiAgICAgICAgICAgIFtQYXJhbWV0ZXIoTWFuZGF0b3J5ID0gJHRydWUpXQogICAgICAgICAgICBbc3RyaW5nXQogICAgICAgICAgICAkUGFja2FnZVVybCwKICAgICAgICAgICAgW1BhcmFtZXRlcihNYW5kYXRvcnkgPSAkdHJ1ZSldCiAgICAgICAgICAgIFtzdHJpbmddCiAgICAgICAgICAgICRVbnppcFBhdGgKICAgICAgICApCiAgICAgICAgdHJ5IHsKCiAgICAgICAgICAgIFdyaXRlLUluZm9ybWF0aW9uIC1NZXNzYWdlRGF0YSAiRG93bmxvYWRpbmcgdGhlIHppcCBwYWNrYWdlIGZyb20gdGhlICRQYWNrYWdlVXJsIgogICAgICAgICAgICAkcGFja2FnZSA9IEludm9rZS1XZWJSZXF1ZXN0ICRQYWNrYWdlVXJsIC1Vc2VCYXNpY1BhcnNpbmcKCiAgICAgICAgICAgIFdyaXRlLUluZm9ybWF0aW9uIC1NZXNzYWdlRGF0YSAiQ3JlYXRpbmcgYSBuZXcgdGVtcG9yYXJ5IGRpcmVjdG9yeSIKICAgICAgICAgICAgJHRlbXBEaXIgPSBOZXctSXRlbSAtSXRlbVR5cGUgRGlyZWN0b3J5IC1QYXRoIChKb2luLVBhdGggJGVudjpURU1QIChbU3lzdGVtLkd1aWRdOjpOZXdHdWlkKCkuVG9TdHJpbmcoKSkpCgogICAgICAgICAgICBXcml0ZS1JbmZvcm1hdGlvbiAtTWVzc2FnZURhdGEgIlNhdmluZyB0aGUgcGFja2FnZSBjb250ZW50IHRvIGEgdGVtcG9yYXJ5IGZpbGUiCiAgICAgICAgICAgICR0ZW1wRmlsZSA9IEpvaW4tUGF0aCAkdGVtcERpci5GdWxsTmFtZSAicGFja2FnZS56aXAiCiAgICAgICAgICAgIFtJTy5GaWxlXTo6V3JpdGVBbGxCeXRlcygkdGVtcEZpbGUsICRwYWNrYWdlLkNvbnRlbnQpCiAgICAgICAgCiAgICAgICAgICAgIFdyaXRlLUluZm9ybWF0aW9uIC1NZXNzYWdlRGF0YSAiRXh0cmFjdGluZyB0aGUgY29udGVudHMgb2YgdGhlIHppcCBmaWxlIHRvIHRoZSBkZXN0aW5hdGlvbiBkaXJlY3RvcnkiCiAgICAgICAgICAgIEV4cGFuZC1BcmNoaXZlIC1QYXRoICR0ZW1wRmlsZSAtRGVzdGluYXRpb25QYXRoICRVbnppcFBhdGggLUZvcmNlCgogICAgICAgICAgICBXcml0ZS1JbmZvcm1hdGlvbiAtTWVzc2FnZURhdGEgIlJlbW92aW5nIHRoZSB0ZW1wb3JhcnkgZGlyZWN0b3J5IGFuZCBpdHMgY29udGVudHMiCiAgICAgICAgICAgIFJlbW92ZS1JdGVtICR0ZW1wRGlyLkZ1bGxOYW1lIC1SZWN1cnNlIC1Gb3JjZQogICAgICAgIH0KICAgICAgICBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUVycm9yIC1NZXNzYWdlICJGYWlsZWQgdG8gZG93bmxvYWQgYW5kIHVuemlwIHBhY2thZ2UgZnJvbSAkVXJsLiAkXyIKICAgICAgICB9CiAgICB9CgogICAgZnVuY3Rpb24gSW52b2tlLUhhcmRlbmluZ0tpdHR5SGVscGVyIHsKICAgICAgICBbQ21kbGV0QmluZGluZygpXQogICAgICAgIHBhcmFtICgKICAgICAgICAgICAgW1BhcmFtZXRlcihNYW5kYXRvcnkgPSAkdHJ1ZSldCiAgICAgICAgICAgIFtzdHJpbmddCiAgICAgICAgICAgICRGaWxlRmluZGluZ0xpc3QsCiAgICAgICAgICAgIFtQYXJhbWV0ZXIoTWFuZGF0b3J5ID0gJHRydWUpXQogICAgICAgICAgICBbc3RyaW5nXQogICAgICAgICAgICAkSGFyZGVuaW5nS2l0dHlQYXRoCiAgICAgICAgKQogICAgICAgIHRyeSB7CiAgICAgICAgICAgIFdyaXRlLUluZm9ybWF0aW9uIC1NZXNzYWdlRGF0YSAiSW1wb3J0aW5nIHRoZSBIYXJkZW5pbmdLaXR0eSBtb2R1bGUiCiAgICAgICAgICAgIEltcG9ydC1Nb2R1bGUgLU5hbWUgKEpvaW4tUGF0aCAtUGF0aCAkSGFyZGVuaW5nS2l0dHlQYXRoIC1DaGlsZFBhdGggIkhhcmRlbmluZ0tpdHR5LnBzbTEiKSAtRXJyb3JBY3Rpb24gU3RvcAogICAgICAgIH0KICAgICAgICBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUVycm9yIC1NZXNzYWdlICJGYWlsZWQgdG8gaW1wb3J0IG1vZHVsZSBmcm9tICRIYXJkZW5pbmdLaXR0eVBhdGguICRfIgogICAgICAgICAgICByZXR1cm4KICAgICAgICB9CiAgICAKICAgICAgICB0cnkgewogICAgICAgICAgICBXcml0ZS1JbmZvcm1hdGlvbiAtTWVzc2FnZURhdGEgIkludm9raW5nIHRoZSBIYXJkZW5pbmdLaXR0eSBzY3JpcHQgd2l0aCB0aGUgRmlsZUZpbmRpbmdMaXN0IHByb3ZpZGVkIgogICAgICAgICAgICBJbnZva2UtSGFyZGVuaW5nS2l0dHkgLUZpbGVGaW5kaW5nTGlzdCAkRmlsZUZpbmRpbmdMaXN0IC1Nb2RlIEhhaWxNYXJ5IC1Mb2cgLVJlcG9ydCAtU2tpcFJlc3RvcmVQb2ludAogICAgICAgIH0KICAgICAgICBjYXRjaCB7CiAgICAgICAgICAgIFdyaXRlLUVycm9yIC1NZXNzYWdlICJGYWlsZWQgdG8gcnVuIEludm9rZS1IYXJkZW5pbmdLaXR0eS4gJF8iCiAgICAgICAgfQogICAgfQoKICAgICRHZXRVbnppcHBlZFBhY2thZ2VQYXJhbXMgPSBAeyAKICAgICAgICBQYWNrYWdlVXJsID0gJFBhY2thZ2VVcmwgCiAgICAgICAgVW56aXBQYXRoICA9ICRVbnppcFBhdGgKICAgIH0KICAgIEdldC1VbnppcHBlZFBhY2thZ2UgQEdldFVuemlwcGVkUGFja2FnZVBhcmFtcwoKICAgICRJbnZva2VIYXJkZW5pbmdLaXR0eUhlbHBlclBhcmFtcyA9IEB7CiAgICAgICAgRmlsZUZpbmRpbmdMaXN0ICAgID0gJEZpbGVGaW5kaW5nTGlzdCAKICAgICAgICBIYXJkZW5pbmdLaXR0eVBhdGggPSAkSGFyZGVuaW5nS2l0dHlQYXRoCiAgICB9CiAgICBJbnZva2UtSGFyZGVuaW5nS2l0dHlIZWxwZXIgQEludm9rZUhhcmRlbmluZ0tpdHR5SGVscGVyUGFyYW1zCn0KCkludm9rZS1IYXJkZW5pbmcgCg=="
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
  name                     = "cnsa${random_string.append_random_chars.result}"
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
