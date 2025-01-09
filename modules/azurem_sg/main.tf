resource "azurerm_network_security_group" "azurem-sg" {
  name                = "azurem_sg"
  location            = var.azurem_rg_location
  resource_group_name = var.azurem_rg_name

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
    name                       = "python-server-port"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
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

output "azurem_sg_id" {
    value = azurerm_network_security_group.azurem-sg.id
  
}
