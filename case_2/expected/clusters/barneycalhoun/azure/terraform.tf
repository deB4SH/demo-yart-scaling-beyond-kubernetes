
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-blueshift-tf-backend"
    storage_account_name = "blueshifttfbackend"
    container_name       = "tfstate"
    key                  = "blueshift" # refers to the file name
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