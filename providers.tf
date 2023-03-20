
# Update this block with the location of your terraform state file
#   backend "azurerm" {
#     resource_group_name  = "rg-terraform-github-actions-state"
#     storage_account_name = "terraformgithubactions"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#     use_oidc             = true
#   }
# }

provider azurerm {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id

  features {}
}

