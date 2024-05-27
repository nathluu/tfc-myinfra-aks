resource "azurerm_resource_group" "rg" {
    name     = local.aks.resource-group-name
    location = local.aks.location
}

resource "azurerm_virtual_network" "vnet" {
    name                = local.aks.vnet-name
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    name                 = local.aks.subnet-name
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["192.168.1.0/24"]
    service_endpoints    = ["Microsoft.ContainerRegistry"]
}

resource "azurerm_kubernetes_cluster" "aks" {
    count                     = var.create-resource ? 1 : 0
    name                      = local.aks.name
    location                  = azurerm_resource_group.rg.location
    resource_group_name       = azurerm_resource_group.rg.name
    sku_tier                  = local.aks.sku
    dns_prefix                = "natcom"
    # automatic_channel_upgrade = none
    private_cluster_enabled   = local.aks.private-cluster-enabled

    default_node_pool {
        name                    = "default"
        vm_size                 = "Standard_D4s_v3"
        vnet_subnet_id          = azurerm_subnet.subnet.id
        type                    = "VirtualMachineScaleSets"
        enable_auto_scaling     = true
        enable_node_public_ip   = false
        max_count               = 3
        min_count               = 1
    }

    azure_active_directory_role_based_access_control {
        managed                 = true
        azure_rbac_enabled      = true
        admin_group_object_ids  = local.aks.admin_group_object_ids
    }

    identity {
        type = "SystemAssigned"
    }

    network_profile {
        network_plugin     = "kubenet"
        # network_policy     = "calico"
        # dns_service_ip     = "10.0.2.10"
        # pod_cidr           = "10.10.0.0/16"
        # service_cidr       = "10.0.2.0/24"
        load_balancer_sku  = "standard"
    }
}
