output "master_ip_addresses" {
  value = module.kubernetes.master_ip
}

output "worker_ip_addresses" {
  value = module.kubernetes.worker_ip
}

output "ovirt_datacenter" {
  value = var.ovirt_datacenters
}

output "ovirt_cluster" {
  value = var.ovirt_clusters
}

output "ovirt_storagedomains" {
  value = var.ovirt_storagedomains
}

output "ovirt_networks" {
  value = var.ovirt_networks
}

output "ovirt_hosts" {
  value = var.ovirt_hosts
}

