terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "gh-tf-storage-rg01"
#     storage_account_name = "rjukstfstgacc01"
#     container_name       = "poc1-tfstate"
#     key                  = "terraform.tfstate"
#     use_oidc             = true
#     client_id            = "cb96d2df-220e-482d-a048-40ca97eb05e2"
#     subscription_id      = "d425d56b-b751-47db-9b41-a7cffd203508"
#     tenant_id            = "010af096-c756-4d39-9edd-a2607c57d24d"
#     use_azuread_auth     = true
#   }
# }

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name combined with a random ID."
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}


