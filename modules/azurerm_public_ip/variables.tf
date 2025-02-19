variable "azurerm_eni_name" {
    default = "azurerm-publicip"
  
}

variable "azurerm_rg_name" {
    description = "value for this exists in module azurerm_rg, will pass it's value from root module"
  
}

variable "azurerm_rg_location" {
    description = "value for this exists in module azurerm_rg, will pass it's value from root module"
}

variable "allocation_method" {
    default = "Static"
  
}

variable "env_tag" {
    default = "Dev"
  
}