provider "azurerm" {
  features {}
}

module "azurem_resource_group" {
  source = "./modules/azurem_rg"
}

module "azurem_security_group" {
  source = "./modules/azurem_sg"
  azurem_rg_name = module.azurem_resource_group.azurem_rg_name
  azurem_rg_location = module.azurem_resource_group.azurem_rg_location
}

resource "azurerm_network_interface" "azurem-eni" {
  name                = "azurem-eni"
  location            = module.azurem_resource_group.azurem_rg_location
  resource_group_name = module.azurem_resource_group.azurem_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azurem-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.4"
    public_ip_address_id          = module.azurerm_public_ip.azurem_public_ip_id
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.azurem-eni.id
  network_security_group_id = module.azurem_security_group.azurem_sg_id
}

resource "azurerm_virtual_network" "azurem-vnet" {
  name                = "azurem-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = module.azurem_resource_group.azurem_rg_location
  resource_group_name = module.azurem_resource_group.azurem_rg_name
}

resource "azurerm_subnet" "azurem-subnet" {
  name                 = "internal"
  resource_group_name  = module.azurem_resource_group.azurem_rg_name
  virtual_network_name = azurerm_virtual_network.azurem-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "azurerm_public_ip" {
  source = "./modules/azurem_public_ip"
  azurem_rg_name = module.azurem_resource_group.azurem_rg_name
  azurem_rg_location = module.azurem_resource_group.azurem_rg_location

}


resource "azurerm_linux_virtual_machine" "azurem-vm" {
  name                = "azurem-vm"
  resource_group_name = module.azurem_resource_group.azurem_rg_name
  location            = module.azurem_resource_group.azurem_rg_location
  size                = "Standard_B1s"
  admin_username      = "debian"
  network_interface_ids = [
    azurerm_network_interface.azurem-eni.id,
  ]

  admin_ssh_key {
    username   = "debian"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-12"
    sku       = "12-gen2"
    version   = "latest"
  }

}

