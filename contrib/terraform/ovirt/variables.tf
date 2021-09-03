## Global ##

variable "prefix" {
  default = ""
}

variable "machines" {
  description = "Cluster machines"
  type = map(object({
    node_type = string
    ips       = list(string)
  }))
}

variable "inventory_file" {
  default = "inventory.ini"
}

# default.tfvars
# provider
variable "ovirt_username" {}

variable "ovirt_password" {}

variable "ovirt_url" {}

variable "ovirt_cafile" {}

variable "ovirt_datacenters" {}

variable "ovirt_clusters" {}

variable "ovirt_storagedomains" {}

variable "ovirt_networks" {}

variable "ovirt_hosts" {}

variable "template_name" {}

variable "ansible_user" {}

variable "gateways" {}

variable "authorized_ssh_key" {}


variable "dns_primary" {
  default = "8.8.8.8"
}

variable "dns_secondary" {
  default = "8.8.8.8"
}

## Master ##
variable "master_cores" {
  default = 4
}

variable "master_memory" {
  default = 4096
}

## Worker ##
variable "worker_cores" {
  default = 4
}

variable "worker_memory" {
  default = 4096
}
