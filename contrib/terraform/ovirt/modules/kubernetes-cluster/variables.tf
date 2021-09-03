## Global ##
variable "prefix" {}

variable "machines" {
  description = "Cluster machines"
  type = map(object({
    node_type = string
    ips       = list(string)
  }))
}

variable "gateways" {}
variable "dns_primary" {}
variable "dns_secondary" {}
variable "template_id" {}
variable "cluster_id" {}
variable "authorized_ssh_key" {}
variable "ansible_user" {}

## Master ##
variable "master_cores" {}
variable "master_memory" {}

## Worker ##
variable "worker_cores" {}
variable "worker_memory" {}
