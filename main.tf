terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_url 
}

module "k3s_nodes" {
  source = "./modules/vm"
  for_each = { for node in var.k3s_nodes: node.hostname => node }
  hostname = each.value.hostname
  ip = each.value.ip
  username = each.value.username
  password = each.value.password
  mac = each.value.mac
  netmask = each.value.netmask
  nameservers = each.value.nameservers
  gateway = each.value.gateway
  k3s_hosts = var.k3s_hosts
}
