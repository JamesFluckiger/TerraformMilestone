terraform {
  cloud {
    organization = "jamesafluke1"

    workspaces {
      name = "Terraform_Module_ACE_workspace"
    }
  }


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.6.0"
    }
  }
}

provider "azurerm" {
  features {}

  # CDW sub
  # subscription_id = "3c2067eb-14d4-42da-83ca-73316e5fce7a"
  # client_id       = "ZgT8Q~uB3toXh_b06PFKxOZA33hQFVKPZKpMGa_Y"
  # client_secret   = var.client_secret
  # tenant_id       = "c022673d-2b5c-406e-bb6a-d9e40ee64bc9"

}



locals {
  rg_name  = "terraformtest"
  env      = "DevTest"
  loc      = "wus"
  location = "West Us"
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.rg_name}-${local.env}-${local.loc}"
  location = local.location
  tags     = { "terraform" = true }
}

