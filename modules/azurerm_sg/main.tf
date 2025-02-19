resource "azurerm_network_security_group" "azurerm-sg" {
  name                = "azurerm_sg"
  location            = var.azurerm_rg_location
  resource_group_name = var.azurerm_rg_name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"                          
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "http"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  # Optional ports
    security_rule {
    name                       = "Allow all inbound"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"                          
    destination_address_prefix = "*"
  }


}

output "azurerm_sg_id" {
    value = azurerm_network_security_group.azurerm-sg.id
  
}
