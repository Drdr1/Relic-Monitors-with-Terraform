terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.0"
    }
  }
}

resource "newrelic_synthetics_script_monitor" "monitor" {
  for_each = { for model in var.models : model.name => model }

  name         = "Monitor-${each.value.name}"
  type         = "SCRIPT_API"
  period       = "EVERY_5_MINUTES"
  locations_public = var.monitor_locations 
  status       = "ENABLED"
  
  # Required runtime configuration (added these fields)
  runtime_type          = "NODE_API"
  runtime_type_version  = "16.10"
  script_language       = "JAVASCRIPT"

  script = templatefile("${path.module}/monitor_script.tmpl", {
    endpoint   = each.value.endpoint
    api_key    = each.value.api_key_credential
  })
}

resource "newrelic_alert_policy" "policy" {
  name = "Azure-OpenAI-Monitor-Policy"
}

# resource "newrelic_synthetics_monitor_downtime" "alert" {
#   for_each       = newrelic_synthetics_script_monitor.monitor
#   monitor_id     = each.value.id
#   policy_id      = newrelic_alert_policy.policy.id
#   condition_name = "API Failure"
#   condition_type = "static"
#   condition_attributes = {
#     metric_name = "success"
#     operator    = "below"
#     value       = "1"
#   }
# }