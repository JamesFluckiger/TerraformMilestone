terraform {
  cloud {
    organization = "jamesafluke1"

    workspaces {
      name = "Terraform_Module_ACE_workspace"
    }
  }
}


terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}

  # CDW sub
  subscription_id = "3c2067eb-14d4-42da-83ca-73316e5fce7a"
  tenant_id       = "c022673d-2b5c-406e-bb6a-d9e40ee64bc9"

  # Personal sub
  #   subscription_id = "74c2e3ac-be44-401a-acea-768ddd167a5f"
  #   tenant_id       = "c74940ec-9df1-429e-9e18-5ee10c445e4f"
}



locals {
  rg_name = "terraformtest"
  env = "DevTest"
  loc = "wus"
  location = "West Us"
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.rg_name}-${local.env}-${local.loc}"
  location = local.location
  tags     = { "terraform" = true }
}

