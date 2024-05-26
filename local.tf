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
}