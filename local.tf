locals {
    aks = {
        name                    = "natcom-aks-01"
        resource-group-name     = "natcom-aks-rg"
        location                = "southeastasia"
        vnet-name               = "natcom-aks-vnet"
        subnet-name             = "natcom-aks-snet"
        sku                     = "Standard"
        private-cluster-enabled = false
    }
}