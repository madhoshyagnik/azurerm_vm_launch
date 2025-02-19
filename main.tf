provider "azurerm" {
  features {}
}

module "azurerm_resource_group" {
  source = "./modules/azurerm_rg"
}

module "azurerm_security_group" {
  source = "./modules/azurerm_sg"
  azurerm_rg_name = module.azurerm_resource_group.azurerm_rg_name
  azurerm_rg_location = module.azurerm_resource_group.azurerm_rg_location
}

resource "azurerm_network_interfacazureme" "azurerm-eni" {
  name                = "azurerm-eni"
  location            = module.azurerm_resource_group.azurerm_rg_location
  resource_group_name = module.azurerm_resource_group.azurerm_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azurerm-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.4"
    public_ip_address_id          = module.azurerm_public_ip.azurerm_public_ip_id
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.azurerm-eni.id
  network_security_group_id = module.azurerm_security_group.azurerm_sg_id
}

resource "azurerm_virtual_network" "azurerm-vnet" {
  name                = "azurerm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = module.azurerm_resource_group.azurerm_rg_location
  resource_group_name = module.azurerm_resource_group.azurerm_rg_name
}

resource "azurerm_subnet" "azurerm-subnet" {
  name                 = "internal"
  resource_group_name  = module.azurerm_resource_group.azurerm_rg_name
  virtual_network_name = azurerm_virtual_network.azurerm-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "azurerm_public_ip" {
  source = "./modules/azurerm_public_ip"
  azurerm_rg_name = module.azurerm_resource_group.azurerm_rg_name
  azurerm_rg_location = module.azurerm_resource_group.azurerm_rg_location

}


resource "azurerm_linux_virtual_machine" "azurerm-vm" {
  name                = "azurerm-vm"
  resource_group_name = module.azurerm_resource_group.azurerm_rg_name
  location            = module.azurerm_resource_group.azurerm_rg_location
  size                = "Standard_B1ls"
  admin_username      = "debian"
  network_interface_ids = [
    azurerm_network_interface.azurerm-eni.id,
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

