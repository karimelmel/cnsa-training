/*
resource "random_string" "append_random_chars2" {
  length  = 7
  upper   = false
  numeric = false
  lower   = true
  special = false
}


resource "azurerm_storage_account" "res-13" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = "westeurope"
  min_tls_version          = "TLS1_0"
  name                     = "cnsa${random_string.append_random_chars2.result}"
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
