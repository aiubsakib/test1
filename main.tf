terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
 backend "azurerm" {
    resource_group_name  = "friday-demo-rg"
    storage_account_name = "sttfstatemgt01"
    container_name       = "tfstate"
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



