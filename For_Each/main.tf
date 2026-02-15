# #----for_each+ list---exmaple , multiple rgs getting created in same location
# resource "azurerm_resource_group" "rgterra" {
#   #toset Function toset converts its argument to a set value.
#   #Pass a list value to toset to convert it to a set, which will remove any duplicate elements and discard the ordering of the elements.  
#   for_each = toset(var.rgs)   
#   name     = each.value
#   location = "Central India"
# }

# #---for_each+map--- creating multiple rgs in multiple location by passing values in key value pair
# resource "azurerm_resource_group" "rgterra" {
#   for_each = var.rgs
#   name     = each.key
#   location = each.value

# }

# ---for_each + Nested Map---Creating multiple rgs in multiple location by passing multiple values like name ,location & any additional arguments
resource "azurerm_resource_group" "rgterra" {
  for_each = var.rgs
  name     = each.value.name
  location = each.value.location
}

