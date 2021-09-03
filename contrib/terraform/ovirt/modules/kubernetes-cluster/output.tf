output "master_ip" {
  value = {
    for instance in ovirt_vm.master :
    instance.name => instance.initialization[0].nic_configuration[0].address
  }
}

output "worker_ip" {
  value = {
    for instance in ovirt_vm.worker :
    instance.name => instance.initialization[0].nic_configuration[0].address
  }
}
