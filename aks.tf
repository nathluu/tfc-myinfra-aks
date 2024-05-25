resource "azurerm_resource_group" "aks_rg" {
    name     = local.aks.resource-group-name
    location = local.aks.location
}

resource "azurerm_virtual_network" "aks_vnet" {
    name                = local.aks.vnet-name
    location            = azurerm_resource_group.aks_rg.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "aks_snet" {
    name                 = local.aks.subnet-name
    resource_group_name  = azurerm_resource_group.aks_rg.name
    virtual_network_name = azurerm_virtual_network.aks_vnet.name
    address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
    count                     = var.create-resource ? 1 : 0
    name                      = local.aks.name
    location                  = azurerm_resource_group.aks_rg.location
    resource_group_name       = azurerm_resource_group.aks_rg.name
    sku_tier                  = local.aks.sku
    #   dns_prefix          = "<dns-prefix>"
    automatic_channel_upgrade = "none"
    private_cluster_enabled   = local.aks.private-cluster-enabled

    default_node_pool {
        name            = "default"
        node_count      = 1
        vm_size         = "Standard_D2_v2"
        vnet_subnet_id  = azurerm_subnet.aks_snet.id
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        network_plugin     = "kubenet"
        network_policy     = "calico"
        dns_service_ip     = "10.0.2.10"
        pod_cidr           = "10.10.0.0/16"
        service_cidr       = "10.0.2.0/24"
        load_balancer_sku  = "standard"
    }
}
