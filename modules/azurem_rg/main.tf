resource "azurerm_resource_group" "azurem_rg" {
  name     = var.azurem_rg_name
  location = var.azurem_rg_location
}

output "azurem_rg_name" {
  value = azurerm_resource_group.azurem_rg.name
  
}


output "azurem_rg_location" {
  value = azurerm_resource_group.azurem_rg.location
  
}



