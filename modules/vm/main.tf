data "template_file" "cloud_init_user_datas" {
  template = file("${path.module}/templates/cloud_init_user_data.tpl")
  vars = {
    hostname = var.hostname
    ip = var.ip
    username = var.username
    password = var.password
    ssh_key = var.ssh_public_key
    hosts = var.k3s_hosts
  }
}

data "template_file" "cloud_init_network_config" {
  template = file("${path.module}/templates/cloud_init_network_config.tpl")
  vars = {
    nameservers = var.nameservers
    netmask = var.netmask
    gateway = var.gateway
    ip = var.ip
    mac = var.mac
  }
  
}

resource "libvirt_pool" "default" {
  name = "default"
  type = "dir"
  path = var.libvirt_pool_path
}

resource "libvirt_cloudinit_disk" "k3s-node-cloudinit" {
  name       = "${var.hostname}-cloudinit.iso"
  user_data  = data.template_file.cloud_init_user_data.rendered
  meta_data = <<-EOF
instance-id: ${var.hostname}
local-hostname: ${var.hostname}
EOF
  network_config = data.template_file.cloud_init_network_config.rendered
  pool       = libvirt_pool.default.name
}


resource "libvirt_volume" "k3s-node-img" {
  name     = "${var.hostname}.qcow2"
  pool     = libvirt_pool.default.name
  source   = var.base_image
  format   = "qcow2"
}

resource "libvirt_volume" "k3s-node-disk" {
  name     = "${var.hostname}-disk"
  base_volume_id = libvirt_volume.k3s-node-img.id
  pool     = libvirt_pool.default.name
  size     = var.vm_disk_size 
}

resource "libvirt_network" "k3s-network" {
  name = var.bridge_network
  mode = "bridge"
  bridge = var.bridge_network
  autostart = true
  
}

resource "libvirt_domain" "k3s-node" {
  name   = var.hostname
  memory = var.vm_memory
  vcpu   = var.vm_cpu

  disk {
    volume_id = libvirt_volume.k3s-node-disk.id
  }


  network_interface {
    network_id = libvirt_network.k3s-network.id
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
}