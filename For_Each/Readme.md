The for_each meta-argument in Terraform is used with the azurerm provider to create and manage multiple, similar Azure resources without writing separate configuration blocks for each one. It iterates over a map or a set of strings, creating a unique instance for each item, which helps keep the configuration cleaner and more dynamic. 
Key Concepts
Meta-Argument: for_each is a built-in Terraform meta-argument, applicable to resource, data, and module blocks.
Iteration: It accepts a map or a set of strings. For each entry, Terraform creates one instance of the resource.
each Object: Within a block using for_each, the special each object is available. It has two attributes:
each.key: The map key or set member for the current instance.
each.value: The map value for the current instance (or the same as each.key for a set).
Unique Identity: Each created instance has a distinct identifier based on its key, allowing individual reference in other parts of the configuration using the syntax <TYPE>.<NAME>[<KEY>] (e.g., azurerm_resource_group.rg["group_a"]).
Dynamic Values: The values used in for_each must be known before Terraform performs any remote resource actions (i.e., during the plan phase). 
Example: Creating Multiple Azure Resource Groups
This example demonstrates how to define a variable containing the configuration for multiple Azure resource groups and then use for_each to create them.
hcl
# Define a map of objects for resource group configurations
variable "resource_groups" {
  type = map(object({
    location = string
  }))
  default = {
    "rg-prod-eastus" = {
      location = "eastus"
    },
    "rg-dev-westus" = {
      location = "westus"
    },
    "rg-staging-centralus" = {
      location = "centralus"
    }
  }
}

# Use the azurerm provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the AzureRM provider
provider "azurerm" {
  features {}
}

# Create a resource group for each item in the variable
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  # each.key refers to the map key (e.g., "rg-prod-eastus")
  name = each.key
  # each.value refers to the object value, and each.value.location refers to the 'location' attribute
  location = each.value.location
}

# Output the names and locations of the created resource groups
output "resource_group_details" {
  value = {
    for k, v in azurerm_resource_group.rg : k => v.location
  }
}