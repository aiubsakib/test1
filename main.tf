# Configure the Microsoft Azure Provider
provider "azurerm" {
   version = "~> 2.29.0" 
  features {}
}
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-cloud"
    storage_account_name = "storagecontainer88"
    container_name       = "terraformtffile"
    key                  = "terraform.tfstate"
  }
}
#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "tamops"
  location = "eastus2"
}



