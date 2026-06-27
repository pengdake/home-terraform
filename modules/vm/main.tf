terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}


resource "libvirt_cloudinit_disk" "init" {
  name      = "vm-init"
  user_data = templatefile(
    "${path.module}/templates/cloud_init_user_data.tpl",
    {
      hosts = var.k3s_hosts
      hostname = var.hostname
      ip = var.ip
      username = var.username
      password = var.password
      ssh_key = var.ssh_public_key
    }
  )
  meta_data = yamlencode({
    instance-id    = var.hostname
    local-hostname = var.hostname
  })
  network_config = templatefile(
    "${path.module}/templates/cloud_init_network_config.tpl",
    {
      nameservers = join(",", var.nameservers)
      netmask = var.netmask
      gateway = var.gateway
      ip = var.ip
      mac = var.mac
    }
  )
}

resource "libvirt_volume" "cloudinit" {
  name   = "${var.hostname}-cloudinit.iso"
  pool   = var.libvirt_pool_name
  create = {
    content = {
      url = libvirt_cloudinit_disk.init.path
    }
  }
}




resource "libvirt_volume" "k3s-node-disk" {
  name     = "${var.hostname}-disk"
  pool = var.libvirt_pool_name
  capacity = var.vm_disk_size 
  target = {
    format = {
      type = "qcow2"
    }
  }
}

resource "libvirt_volume" "k3s-node-rancher-disk" {
  name     = "${var.hostname}-rancher-disk"
  pool = var.libvirt_pool_name
  capacity = var.vm_disk_size 
  target = {
    format = {
      type = "qcow2"
    }
  }
}

resource "libvirt_volume" "k3s-node-root-disk" {
  name     = "${var.hostname}-root-disk"
  pool = var.libvirt_pool_name
  capacity = var.vm_root_size
  target = {
    format = {
      type = "qcow2"
    }
  }
  backing_store = {
    path = var.base_img_path
    format = {
      type = "qcow2"
    }
  }
}


resource "libvirt_domain" "k3s-node" {
  name   = var.hostname
  memory = var.vm_memory
  vcpu   = var.vm_cpu
  vcpu_current = var.vm_current_cpu
  current_memory = var.vm_current_memory
  autostart = true
  type  = "kvm"

  cpu ={
    mode = "host-passthrough"
  }

  os = {
    type = "hvm"
    type_arch = "x86_64"
    # boot_devices = ["hd", "network"]
    boot_device = [
      { dev = "hd" },
      { dev = "network" }
    ]
    kernel_args = "console=tty0 console=ttyS0,115200n8 root=/dev/vda1"
  }

  devices = {
    disks = [
      {
        source = {
          volume = {
            pool = var.libvirt_pool_name
            volume = libvirt_volume.k3s-node-root-disk.name
          }
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
        driver = {
          type = "qcow2"
        }
      },
      {
        source = {
          volume = {
            pool = var.libvirt_pool_name
            volume = libvirt_volume.k3s-node-disk.name
          }
        }
        target = {
          dev = "vdb"
          bus = "virtio"
        }
        driver = {
          type = "qcow2"
        }
      },
      {
        source = {
          volume = {
            pool = var.libvirt_pool_name
            volume = libvirt_volume.k3s-node-rancher-disk.name
          }
        }
        target = {
          dev = "vdc"
          bus = "virtio"
        }
        driver = {
          type = "qcow2"
        }
      },
      {
        device = "cdrom"
        source = {
          volume = {
            pool = var.libvirt_pool_name
            volume = libvirt_volume.cloudinit.name
          }
        }
        target = {
          dev = "sda"
          bus = "sata"
        }
      }
    ]
    interfaces = [
      {
        model = {
          type = "virtio"
        }
        mac = {
          address = var.mac
        }
        source = {
          bridge = {
            bridge = var.bridge_network
          }
        }
      }
    ]
    graphics = [
      {
        vnc = {
          listen = "0.0.0.0"
          autoport    = false
          port        = 5901
          passwd      = var.vnc_password
        }
      }
    ]
    consoles = [
      {
        type        = "pty"
        target_type = "serial"
        target_port = "0"
      }
    ]
  }
  running = true
}