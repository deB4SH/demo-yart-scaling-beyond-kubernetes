
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-black-mesa-tf-backend"
    storage_account_name = "halflifetfbackend"
    container_name       = "tfstate"
    key                  = "blackmesa" # refers to the file name
  }
}


terraform {
  required_version = ">= 1.3.0"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 4.0.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.39.0"
    }
  }
}