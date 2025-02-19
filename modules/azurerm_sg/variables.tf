variable "azurerm_sg_name" {
    default = "azurerm_sg"
}

variable "azurerm_rg_name" {
    description = "value for this exists in module azurem_rg, will pass it's value from root module"
  
}

variable "azurerm_rg_location" {
    description = "value for this exists in module azurem_rg, will pass it's value from root module"
}