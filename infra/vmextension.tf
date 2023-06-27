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

resource "azurerm_virtual_machine_extension" "res-3" {
  auto_upgrade_minor_version = true
  name                       = "InvokeHardening"
  publisher                  = "Microsoft.Compute"
  settings                   = "{\"commandToExecute\":\"powershell.exe -ExecutionPolicy Bypass -File Get-AzIrInstanceMetadata.ps1\",\"fileUris\":[\"https://gist.githubusercontent.com/karimelmel/bd66585573d3ce1e98370427f75207e9/raw/bcb22bb53988cfc43c306544ba51f9aac688ff32/Get-AzIrInstanceMetadata.ps1\"],\"managedIdentity\":{}}"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  virtual_machine_id         = azurerm_windows_virtual_machine.res-1.id
  depends_on = [
    azurerm_windows_virtual_machine.res-1,
  ]
}
