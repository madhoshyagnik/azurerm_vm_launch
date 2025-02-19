terraform { 
  cloud { 
    
    organization = "azurerm_madhosh" 

    workspaces { 
      name = "azurerm_vm_launch" 
    } 
  } 
}