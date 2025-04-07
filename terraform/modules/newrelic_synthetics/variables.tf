variable "models" {
  type = list(object({
    name             = string
    endpoint         = string
    api_key_credential = string # Renamed for clarity
  }))
}

variable "monitor_locations" {
  type    = list(string)
  default = ["AWS_US_EAST_1", "AWS_EU_WEST_1"]
}