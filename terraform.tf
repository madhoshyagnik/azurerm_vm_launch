terraform {
  cloud {

    organization = "azurem"

    workspaces {
      name = "azurem_vm"
    }
  }
} 