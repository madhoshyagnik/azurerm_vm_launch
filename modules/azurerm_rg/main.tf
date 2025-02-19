resource "azurerm_resource_group" "azurerm_rg" {
  name     = var.azurerm_rg_name
  location = var.azurerm_rg_location
}

output "azurerm_rg_name" {
  value = azurerm_resource_group.azurerm_rg.name
  
}


output "azurerm_rg_location" {
  value = azurerm_resource_group.azurerm_rg.location
  
}



