terraform {
  required_version = ">=1.12.0"

  required_providers {
    datadog = {
      version = "3.62.0"
      source  = "datadog/datadog"
    }
  }
}

provider "datadog" {
  api_url = var.dd_provider_api_url
}
