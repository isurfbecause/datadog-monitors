# Datadog Monitors as Code

A Terraform-based solution for managing Datadog monitoring configurations as code.

## Overview

This project allows you to manage Datadog monitors through Terraform, providing version-controlled, repeatable deployments of monitoring configurations across different environments.

## Features

- Infrastructure as Code approach using Terraform
- Environment-specific configurations (dev, prod)
- Monitor templates for critical system metrics:
  - CPU usage
  - Disk space
  - Host availability
  - Memory usage

## Structure

- `monitors/` - JSON templates for monitor configurations
- `dev/` - Development environment configuration
- `prod/` - Production environment configuration
- `*.tf` - Terraform configuration files

## Usage

### Prerequisites

- Terraform installed
- Datadog API and App keys

### Deployment

1. Configure the environment variables in the appropriate `.tfvars` file
2. Initialize Terraform:
   ```
   terraform init
   ```
3. Plan the deployment:
   ```
   terraform plan -var-file=dev/dev.tfvars
   ```
4. Apply the configuration:
   ```
   terraform apply -var-file=dev/dev.tfvars
   ```

## Customization

Modify the variables in `variables.tf` and environment-specific `.tfvars` files to adjust:

- Alert thresholds
- Notification recipients
- Environment-specific settings

