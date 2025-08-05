terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

locals {
  k3s_hosts_set = join("\n", [for host, ip in var.k3s_hosts : "  - echo ${ip} ${host} >> /etc/hosts"])
}

data "template_file" "cloud_init_user_data" {
  template = file("${path.module}/templates/cloud_init_user_data.tpl")
  vars = {
    hostname = var.hostname
    ip = var.ip
    username = var.username
    password = var.password
    ssh_key = var.ssh_public_key
    k3s_hosts_set = local.k3s_hosts_set
  }
}

data "template_file" "cloud_init_network_config" {
  template = file("${path.module}/templates/cloud_init_network_config.tpl")
  vars = {
    nameservers = join(",", var.nameservers)
    netmask = var.netmask
    gateway = var.gateway
    ip = var.ip
    mac = var.mac
  }
  
}

#resource "libvirt_pool" "default" {
#  name = "default"
#  type = "dir"
#  target {
#    path = var.libvirt_pool_path
#  }
#}

resource "libvirt_cloudinit_disk" "k3s-node-cloudinit" {
  name       = "${var.hostname}-cloudinit.iso"
  user_data  = data.template_file.cloud_init_user_data.rendered
  meta_data = <<-EOF
instance-id: ${var.hostname}
local-hostname: ${var.hostname}
EOF
  network_config = data.template_file.cloud_init_network_config.rendered
  # pool       = libvirt_pool.default.name
  pool = var.libvirt_pool_name
}


resource "libvirt_volume" "k3s-node-disk" {
  name     = "${var.hostname}-disk"
  base_volume_id = var.k3s_node_img_id
  pool     = var.libvirt_pool_name
  size     = var.vm_disk_size 
}


resource "libvirt_domain" "k3s-node" {
  name   = var.hostname
  memory = var.vm_memory
  vcpu   = var.vm_cpu

  disk {
    volume_id = libvirt_volume.k3s-node-disk.id
  }

  boot_device {
    dev = [ "hd", "network"]
  }

  network_interface {
    network_id = var.network_id
    mac = var.mac
  }

  cloudinit = libvirt_cloudinit_disk.k3s-node-cloudinit.id

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  qemu_agent = true
}