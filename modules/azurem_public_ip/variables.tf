variable "azurem_eni_name" {
    default = "azurem-publicip"
  
}

variable "azurem_rg_name" {
    description = "value for this exists in module azurem_rg, will pass it's value from root module"
  
}

variable "azurem_rg_location" {
    description = "value for this exists in module azurem_rg, will pass it's value from root module"
}

variable "allocation_method" {
    default = "Static"
  
}

variable "env_tag" {
    default = "Dev"
  
}