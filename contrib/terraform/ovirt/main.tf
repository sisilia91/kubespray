provider "ovirt" {
  username = var.ovirt_username
  password = var.ovirt_password
	url			 = var.ovirt_url
	cafile	 = var.ovirt_cafile
}

data "ovirt_datacenters" "dc" {
  name_regex = var.ovirt_datacenters
}

data "ovirt_clusters" "c" {
  name_regex = var.ovirt_clusters
}

data "ovirt_storagedomains" "std" {
  name_regex = var.ovirt_storagedomains
}

data "ovirt_networks" "nt" {
	name_regex = var.ovirt_networks
}

data "ovirt_hosts" "h" {
	name_regex = var.ovirt_hosts
}

data "ovirt_templates" "t" {
  name_regex = var.template_name
}

locals {
	datacenter		= data.ovirt_datacenters.dc.datacenters.0
	cluster				= data.ovirt_clusters.c.clusters.0
	storagedomain = data.ovirt_storagedomains.std.storagedomains.0
	network				= data.ovirt_networks.nt.networks.0
	host					= data.ovirt_hosts.h.hosts	# list(object)\
	template			= data.ovirt_templates.t.templates.0
}

module "kubernetes" {
  source = "./modules/kubernetes-cluster"

  prefix = var.prefix

  machines = var.machines

  ## Master ##
  master_cores     = var.master_cores
  master_memory    = var.master_memory

  ## Worker ##
  worker_cores     = var.worker_cores
  worker_memory    = var.worker_memory

  ## Global ##
	authorized_ssh_key = var.authorized_ssh_key

  gateways       = var.gateways
  dns_primary   = var.dns_primary
  dns_secondary = var.dns_secondary

	cluster_id	= local.cluster.id
  template_id = local.template.id

	ansible_user = var.ansible_user
}

#
# Generate ansible inventory
#

data "template_file" "inventory" {
  template = file("${path.module}/templates/inventory.tpl")

  vars = {
    connection_strings_master = join("\n", formatlist("%s ansible_user=%s ansible_host=%s etcd_member_name=etcd%d",
      keys(module.kubernetes.master_ip),
			var.ansible_user,
      values(module.kubernetes.master_ip),
    range(1, length(module.kubernetes.master_ip) + 1)))
    connection_strings_worker = join("\n", formatlist("%s ansible_user=%s ansible_host=%s",
      keys(module.kubernetes.worker_ip),
			var.ansible_user,
    values(module.kubernetes.worker_ip)))
    list_master = join("\n", formatlist("%s",
    keys(module.kubernetes.master_ip)))
    list_worker = join("\n", formatlist("%s",
    keys(module.kubernetes.worker_ip)))
  }
}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.inventory_file}"
  }

  triggers = {
    template = data.template_file.inventory.rendered
  }
}
