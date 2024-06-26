# ###################Install Istio (Service Mesh) #######################################
# resource "random_password" "password" {
#     length           = 16
#     special          = true
#     override_special = "_%@"
# }

# data "azurerm_subscription" "current" {
# }

# resource "local_file" "kube_config" {
#     content    = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
#     filename   = ".kube/config"
# }


# resource "null_resource" "set-kube-config" {
#     triggers = {
#         always_run = "${timestamp()}"
#     }

#     provisioner "local-exec" {
#         command = "az aks get-credentials -n ${azurerm_kubernetes_cluster.aks.name} -g ${azurerm_resource_group.rg.name} --file \".kube/${azurerm_kubernetes_cluster.aks.name}\" --admin --overwrite-existing"
#     }
#     depends_on = [local_file.kube_config]
# }


# resource "kubernetes_namespace" "istio_system" {
#     provider = kubernetes.local
#     metadata {
#         name = "istio-system"
#     }
# }

# resource "kubernetes_secret" "grafana" {
#     provider = kubernetes.local
#     metadata {
#         name      = "grafana"
#         namespace = "istio-system"
#         labels = {
#         app = "grafana"
#         }
#     }
#     data = {
#         username   = "admin"
#         passphrase = random_password.password.result
#     }
#     type       = "Opaque"
#     depends_on = [kubernetes_namespace.istio_system]
# }

# resource "kubernetes_secret" "kiali" {
#     provider = kubernetes.local
#     metadata {
#         name      = "kiali"
#         namespace = "istio-system"
#         labels = {
#         app = "kiali"
#         }
#     }
#     data = {
#         username   = "admin"
#         passphrase = random_password.password.result
#     }
#     type       = "Opaque"
#     depends_on = [kubernetes_namespace.istio_system]
# }

# resource "local_file" "istio-config" {
#     content = templatefile("${path.module}/istio-aks.tmpl", {
#         enableGrafana = true
#         enableKiali   = true
#         enableTracing = true
#     })
#     filename = ".istio/istio-aks.yaml"
# }

# resource "null_resource" "istio" {
#     triggers = {
#         always_run = "${timestamp()}"
#     }
#     provisioner "local-exec" {
#         command = "istioctl manifest apply -f \".istio/istio-aks.yaml\" --kubeconfig \".kube/${azurerm_kubernetes_cluster.aks.name}\""
#     }
#     depends_on = [kubernetes_secret.grafana, kubernetes_secret.kiali, local_file.istio-config]
# }