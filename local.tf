locals {
    aks = {
        name                    = "natcom-aks-01"
        resource-group-name     = "natcom-aks-rg"
        location                = "southeastasia"
        vnet-name               = "natcom-aks-vnet"
        subnet-name             = "natcom-aks-snet"
        sku                     = "Standard"
        private-cluster-enabled = false
        admin_group_object_ids  = ["a5d5db85-021c-436f-83b9-9e2b9070a0df"]
    }
    aisearch = {
        name                                = "natcom0aiserach01"
        resource-group-name                 = "natcom-aisearch-rg"
        location                            = "southeastasia"
        vnet-name                           = "natcom-aisearch-vnet"
        subnet-name                         = "natcom-aisearch-snet"
        sku                                 = "basic"
        local_authentication_enabled        = true
        public_network_access_enabled       = true
        allowed_ips                         = []
        partition_count                     = 1
        replica_count                       = 1
        semantic_search_sku                 = "free"
        private-endpoint-enabled            = false
        admin_group_object_ids              = ["a5d5db85-021c-436f-83b9-9e2b9070a0df"]
    }
}