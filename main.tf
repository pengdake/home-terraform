terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri 
}

locals {
  k3s_hosts = { for node in var.k3s_nodes : node.hostname => node.ip }
}

resource "libvirt_network" "k3s-network" {
  name = var.bridge_network
  mode = "bridge"
  bridge = var.bridge_network
  autostart = true
  
}

#resource "libvirt_volume" "k3s-node-img" {
#  name     = var.k3s_node_img_name
#  pool     = var.libvirt_pool_name
#  #source   = var.base_image
#  format   = "qcow2"
#}


module "k3s_node" {
  source = "./modules/vm"
  providers = {
    libvirt = libvirt 
  }
  for_each = { for node in var.k3s_nodes: node.hostname => node if node.libvirt_uri == var.libvirt_uri }
  hostname = each.value.hostname
  ip = each.value.ip
  username = each.value.username
  password = each.value.password
  mac = each.value.mac
  netmask = each.value.netmask
  nameservers = each.value.nameservers
  gateway = each.value.gateway
  k3s_hosts = local.k3s_hosts
  network_id = libvirt_network.k3s-network.id
  k3s_node_img_id = var.k3s_node_img_id
}
