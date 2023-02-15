terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
 backend "azurerm" {
    resource_group_name  = "TerraformDemo"
    storage_account_name = "storageterraform99"
    container_name       = "containertf"
    key                  = "dev.terraform.tfstate"
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
resource "azurerm_monitor_action_group" "ag" {
  name                = "myactiongroup"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "takeaction"
  email_receiver {
    email_address = "aiubsakib@gmail.com"
    name = "sendtoadmin"
  }

}

resource "azurerm_monitor_metric_alert" "alert" {
  name                = "health-metricalert"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_app_service.appservice.id]
  frequency                = "PT5M"
  window_size              = "PT15M"
 
  
  criteria { 
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Healthcheckstatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 90
    
  }
  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }
}

resource "azurerm_monitor_metric_alert" "alert88" {
  name                = "cputime-metricalert"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_app_service.appservice.id]
 
  
  dynamic_criteria { 
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "CPUTime"
    aggregation      = "Total"
    operator         = "GreaterThan"
    alert_sensitivity = "Low"
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

}

resource "azurerm_monitor_metric_alert" "alert99" {
  name                = "response-metricalert"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_app_service_plan.appplan.id]
  frequency                = "PT5M"
  window_size              = "PT15M"
 
  
  criteria { 
    metric_namespace = "Microsoft.Web/serverfarms"
    metric_name      = "MemoryPercentage"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 80

  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

}


