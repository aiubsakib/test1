terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
 backend "azurerm" {
    resource_group_name  = "rg-cloud"
    storage_account_name = "storagecontainer88"
    container_name       = "terraformtffile"
    key                  = "dev.terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = "West Europe"
}



