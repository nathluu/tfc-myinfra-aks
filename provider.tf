provider "azurerm" {
    subscription_id            = var.usr-subscription-id
    tenant_id                  = var.usr-tenant-id
    client_id                  = var.usr-client-id
    client_secret              = var.usr-client-secret
    skip_provider_registration = var.usr-skip-provider-registration
    features {}
}

terraform {
    required_version = ">= 1.8.4"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 3.105.0"
        }
    }
}