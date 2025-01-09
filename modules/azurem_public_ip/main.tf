resource "azurerm_public_ip" "azurem-publicip" {
  name                = "azurem-publicip"
  resource_group_name = var.azurem_rg_name
  location            = var.azurem_rg_location
  allocation_method   = var.allocation_method

  tags = {
    environment = var.env_tag
  }
}


output "azurem_public_ip_id" {
    value = azurerm_public_ip.azurem-publicip.id
  
}