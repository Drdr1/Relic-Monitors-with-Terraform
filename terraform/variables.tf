variable "azure_subscription_id" { type = string }
variable "resource_group_name" { type = string }
variable "newrelic_account_id" { type = number }
variable "newrelic_api_key" { type = string }
variable "monitor_locations" {
  type    = list(string)
  default = ["AWS_US_EAST_1", "AWS_EU_WEST_1"]
}

variable "models" {
  type = list(object({
    name             = string
    endpoint         = string
    api_key_credential = string
  }))
  description = "List of Azure OpenAI models to monitor"
}