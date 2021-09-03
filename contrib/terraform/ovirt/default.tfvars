prefix = "default"

inventory_file = "inventory.ini"

machines = {
  "jungwook-master-0" : {
    "node_type" : "master",
    "ips" : ["172.21.7.203"]
  },
  "jungwook-worker-0" : {
    "node_type" : "worker",
    "ips" : ["172.21.7.204", "1.1.1.1"]
  },
  "jungwook-worker-1" : {
    "node_type" : "worker",
    "ips" : ["172.21.7.205", "1.1.1.1"]
  }
}

gateways = ["172.21.7.1", "1.1.1.1"]

authorized_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDwETawGJqrNRh7G5dneh0fbmPUrU42YW8YRCwk2ewnUD48XzusducqoHvBwXTzfHdAKhbK16ZwdAlzMlU80ydWfNAmzbPFzKpJUxW0e31A2m6aWZfH3V3djo45phK0MyF/cO1yjjLZUibER8K9J63D2UXpAE8vRcLBgSdoXKpq0aRtfGCfGFBTnX0jOBZL3L6/ngGwJsKEelNW8z27Ns/1u4MITQxjsOjxgq8gH2V5Joi/9YbgLkvTK0H5tohG2kINRRRdRYrEhRewX7b6mCiTfOUhy3D3o6zFwynEKl0/5cGPlwfQhZyRXQfYxFYUqcfZD1nEJo00HWSpUOoVlePZ jungwook@jungwook-node"

# provider
ovirt_username					= "admin@internal"
ovirt_password				 	= "tmax@23"
ovirt_url								= "https://tim3-engine.tmax.dom/ovirt-engine/api"
ovirt_cafile						= "/home/jungwook/ca/ca.pem"

ovirt_datacenters  	    = "Default"
ovirt_clusters 					= "Default"
ovirt_storagedomains	  = "disk_storage"
ovirt_networks					= "ovirtmgmt"
ovirt_hosts        			= "tim3-node*"

template_name = "ubuntu*"
ansible_user	= "jungwook"
