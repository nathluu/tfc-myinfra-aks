# resource "azurerm_resource_group" "rg" {
#     name     = local.aisearch.resource-group-name
#     location = local.aisearch.location
# }

# resource "azurerm_virtual_network" "vnet" {
#     name                = local.aisearch.vnet-name
#     location            = azurerm_resource_group.rg.location
#     resource_group_name = azurerm_resource_group.rg.name
#     address_space       = ["10.0.0.0/16"]
# }

# resource "azurerm_subnet" "subnet" {
#     name                 = local.aisearch.subnet-name
#     resource_group_name  = azurerm_resource_group.rg.name
#     virtual_network_name = azurerm_virtual_network.vnet.name
#     address_prefixes     = ["10.0.1.0/24"]
#     service_endpoints    = ["Microsoft.ContainerRegistry"]
# }


# resource "azurerm_search_service" "search_service" {
#     name                            = local.aisearch.name
#     resource_group_name             = azurerm_resource_group.rg.name
#     location                        = azurerm_resource_group.rg.location
#     sku                             = local.aisearch.sku
#     local_authentication_enabled    = local.aisearch.local_authentication_enabled
#     authentication_failure_mode     = local.aisearch.local_authentication_enabled == true ? "http403" : null
#     public_network_access_enabled   = local.aisearch.public_network_access_enabled
#     allowed_ips = local.aisearch.public_network_access_enabled == true? local.aisearch.allowed_ips: null
#     partition_count = local.aisearch.partition_count
#     replica_count = local.aisearch.replica_count
#     semantic_search_sku = (local.aisearch.sku != "free" && local.aisearch.sku != "basic") ? local.aisearch.semantic_search_sku : null

#     lifecycle {
#       ignore_changes = [ tags ]
#     }
# }

# resource "azurerm_private_endpoint" "pe" {
#   name                = "${local.aisearch.name}-pe"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   subnet_id           = azurerm_subnet.subnet.id

#   private_service_connection {
#     name                           = "${local.aisearch.name}-pe-conn"
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_search_service.search_service.id
#     subresource_names              = ["searchservice"]
#   }
# }
