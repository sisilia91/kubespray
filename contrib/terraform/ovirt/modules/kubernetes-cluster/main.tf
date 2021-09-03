resource "ovirt_vm" "worker" {
  for_each = {
    for name, machine in var.machines :
    name => machine
    if machine.node_type == "worker"
  }

	name 				= each.key
  cores		    = var.worker_cores
  memory      = var.worker_memory
	cluster_id 	= var.cluster_id
	template_id = var.template_id

	initialization {
		user_name = var.ansible_user
		authorized_ssh_key = var.authorized_ssh_key
		dns_servers	= var.dns_primary

		# 1
    nic_configuration {
      label      = "enp1s0"
      boot_proto = "static"
      address    = each.value.ips[0]
      gateway    = var.gateways[0]
      netmask    = "255.255.255.0"
    }

		# 2
		nic_configuration {
			# FIXME
      label      = "enp1s1"
      boot_proto = "static"
      address    = each.value.ips[1]
      gateway    = var.gateways[1]
      netmask    = "255.255.255.0"
    }
  }
}

resource "ovirt_vm" "master" {
  for_each = {
    for name, machine in var.machines :
    name => machine
    if machine.node_type == "master"
  }
	
	name 				= each.key
  cores		    = var.master_cores
  memory      = var.master_memory
	cluster_id 	= var.cluster_id
	template_id = var.template_id

	initialization {
		user_name = var.ansible_user
		authorized_ssh_key = var.authorized_ssh_key
		dns_servers	= var.dns_primary
    nic_configuration {
      label      = "enp1s0"
      boot_proto = "static"
      address    = each.value.ips[0]
      gateway    = var.gateways[0]
      netmask    = "255.255.255.0"
    }
  }
}
