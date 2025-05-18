# Datadog Monitors Management with Terraform

## Overview

This project enables you to manage Datadog monitors as code using Terraform. You can export existing monitors from Datadog as JSON, add them to your project, and use Terraform to provision and manage them for different environments (e.g., dev, prod).

---

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) (v1.0+ recommended)
- Datadog account with API and Application keys

> **Security Note:**
> 
> **Never hardcode API or Application keys in code or configuration files.**
> Always inject sensitive credentials (such as API keys or secrets) using environment variables at runtime. Do not commit API keys to source control. For example:
>
> - For CLI tools, set keys like:
>   ```bash
>   export DD_API_KEY=your_api_key
>   export DD_APP_KEY=your_app_key
>   ```
> - For Terraform, reference them as variables and use environment variables or a secrets manager to provide their values.
>
> Ensure your deployment and CI/CD pipelines are configured to inject these secrets securely.
- [Datadog Terraform Provider](https://registry.terraform.io/providers/DataDog/datadog/latest)

---

## Setup Instructions

### 1. Export Existing Monitors from Datadog

- Use the Datadog API or exporter tool to export existing monitors as JSON.

- Each monitor will be saved as a separate JSON file in the `monitors_json` directory.

### 2. Organize JSON Files

- Place exported JSON files in the `monitors/` directory:
  ```
  monitors/
    cpu.json
    memory.json
    ...
  ```
- Edit JSON files as needed for environment-specific differences.

### 3. Integrate with Terraform

- Use the [terraform-provider-datadog](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor) resource.
- Create a Terraform module or script to read the JSON files and create monitors.

Example `main.tf`:
```hcl
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

locals {
  monitor_files = fileset("${path.module}/monitors/${var.environment}", "*.json")
  monitors = [for file in local.monitor_files : jsondecode(file("${path.module}/monitors/${var.environment}/${file}"))]
}

resource "datadog_monitor" "this" {
  for_each = { for monitor in local.monitors : monitor["name"] => monitor }
  name     = each.value["name"]
  type     = each.value["type"]
  query    = each.value["query"]
  message  = each.value["message"]
  # ... map other fields as needed
}
```

- Set up variables for environment, API keys, etc.

### 4. Manage Environments

- Use `.tfvars` files for `dev` and `prod` environments:

```bash
# For dev
tfvars=dev/dev.tfvars
terraform apply -var-file="$tfvars"

# For prod
tfvars=prod/prod.tfvars
terraform apply -var-file="$tfvars"
```

- Store environment-specific variables (such as `environment`, API keys, etc.) in `dev/dev.tfvars` and `prod/prod.tfvars` files. Do not commit sensitive values to version control; use environment variables or secret management for actual secrets.
---

## Tips

- Review and update exported JSON to match Terraform resource schema.
- Use environment-specific overrides where needed.
- Add version control for all monitor JSON files.

---

## Troubleshooting

- Ensure exported JSON matches the expected format for the Terraform provider.
- Check API and APP keys are correct and have sufficient permissions.
- **Never hardcode or commit API keys. Always use environment variables for sensitive credentials.**
- Use `terraform plan` to preview changes before applying.

---

## References

- [Datadog Monitor API Docs](https://docs.datadoghq.com/api/latest/monitors/)
- [Terraform Datadog Provider](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/monitor)
- [Datadog Monitors Exporter](https://github.com/terraform-providers/terraform-provider-datadog/tree/main/tools/monitors-exporter)
