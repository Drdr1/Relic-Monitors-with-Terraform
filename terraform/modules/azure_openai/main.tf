data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_cognitive_account" "openai" {
  name                = var.openai_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

output "account_details" {
  value = {
    name     = data.azurerm_cognitive_account.openai.name
    location = data.azurerm_cognitive_account.openai.location
  }
}
