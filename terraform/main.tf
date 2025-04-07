terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "newrelic" {
  account_id = var.newrelic_account_id
  api_key    = var.newrelic_api_key
}

# Module for my-openai-1
module "azure_openai_1" {
  source              = "./modules/azure_openai"
  resource_group_name = var.resource_group_name
  openai_account_name = "my-openai-1"
}

# Module for my-openai-2
module "azure_openai_2" {
  source              = "./modules/azure_openai"
  resource_group_name = var.resource_group_name
  openai_account_name = "my-openai-2"
}

# New Relic Synthetics module using combined models from models.json
module "newrelic_synthetics" {
  source            = "./modules/newrelic_synthetics"
  models            = var.models
  monitor_locations = var.monitor_locations
}
