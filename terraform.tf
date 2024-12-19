terraform {
  cloud {

    organization = "azurem_aws"

    workspaces {
      name = "azurem_vm_launch"
    }
  }
} 