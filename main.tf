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

#resource "libvirt_volume" "k3s-node-img" {
#  name     = var.k3s_node_img_name
#  pool     = var.libvirt_pool_name
#  #source   = var.base_image
#  format   = "qcow2"
#}


resource "libvirt_volume" "base_img" {
  name   = var.base_img_name
  pool   = var.libvirt_pool_name
  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = var.base_image
    }
  }
}


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
  base_img_path = libvirt_volume.base_img.path
  bridge_network = var.bridge_network
  libvirt_pool_name = var.libvirt_pool_name
  vnc_port = each.value.vnc_port
}
