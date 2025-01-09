variable "azurem_sg_name" {
    default = "azurem_sg"
}

variable "azurem_rg_name" {
    description = "value for this exists in module azurem_rg, will pass it's value from root module"
  
}

variable "azurem_rg_location" {
    description = "value for this exists in module azurem_rg, will pass it's value from root module"
}