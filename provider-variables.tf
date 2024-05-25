variable "usr-subscription-id" {
    type = string
}

variable "usr-tenant-id" {
    type = string
}

variable "usr-client-id" {
    type = string
}

variable "usr-client-secret" {
    type = string
}

variable "usr-skip-provider-registration" {
    type = bool
    default = true
}

variable "create-resource" {
    type = bool
    default = false
    description = "Toggle resource creation"
}