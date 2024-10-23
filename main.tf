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
  use_oidc = true
}

terraform {
  backend "azurerm" {
    resource_group_name  = "gh-tf-storage-rg01"
    storage_account_name = "rjukstfstgacc01"
    container_name       = "poc1-tfstate"
    key                  = "terraform.tfstate"
#    use_oidc             = true
#    use_azuread_auth     = true
  }
}

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

variable "resource_group_location" {
  type        = string
  default     = "uksouth"
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


