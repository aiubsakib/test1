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
    key                  = "terraform1.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "myterraform"
  location = "West Europe"
}
resource "azurerm_app_service_plan" "appplan" {
  name = "sakib-appserviceplan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    size = "S1"
    tier = "Standard"
  }
 
}

resource "azurerm_app_service" "appservice" {
  name = "sakib-appservice"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appplan.id
   https_only            = true
  site_config { 
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2019"
}
}



