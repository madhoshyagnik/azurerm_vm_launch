resource "azurerm_public_ip" "azurerm-publicip" {
  name                = "azurerm-publicip"
  resource_group_name = var.azurerm_rg_name
  location            = var.azurerm_rg_location
  allocation_method   = var.allocation_method

  tags = {
    environment = var.env_tag
  }
}


output "azurerm_public_ip_id" {
    value = azurerm_public_ip.azurerm-publicip.id
  
}