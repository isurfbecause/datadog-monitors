variable "environment" {
  type        = string
  description = "Deployment environment (dev or prod)"
  default     = "prod"
}

variable "alert_recipients" {
  type        = string
  description = "Recipients for Datadog alert notifications"
  default     = "@your-team-email @your-webhook"
}

variable "dd_provider_api_url" {
  description = "The Datadog API URL based off site"
  type        = string
}
