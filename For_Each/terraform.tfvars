# Passing multiple values of rg to create multiple rg same location using for_each 
#rgs = ["rg1","rg2",3]

# # For_each+map creating multiple rgs in multiple location passing values in map with multiple key value pair
# rgs = {
#   rg1   = "Central India"
#   "rg2" = "Australia East"
#   "rg3" = "South India"
# }

# For_each+ nested map creating multiple rgs in multiple location passing values in map with multiple key value pair
rgs = {
  rgA = {
    name     = "rg1"
    location = "Central India"
  }
  "rgB" = {
    name     = "rg2"
    location = "South India"
  }
  rgC = {
    name     = "rg3"
    location = "Australia East"
  }
}
