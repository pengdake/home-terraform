
variable "k3s_nodes" {
    type        = list(object({
        libvirt_uri = string
        hostname = string
        ip   = string
        username = string
        password = string
        mac = string
        netmask = string
        nameservers = list(string)
        gateway = string
    }))
    default     = []
}

variable "libvirt_uri" {
    type        = string
    default     = "qemu+ssh://root@192.168.31.97/system"
    description = "Libvirt connection URL"
  
}

variable "bridge_network" {
    type        = string
    default     = "br0"
    description = "Bridge network name for K3s nodes"
  
}

variable "base_image" {
    type        = string
    default     = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
    description = "Base image URL for K3s nodes"
}

variable "libvirt_pool_name" {
    type        = string
    default     = "default"
    description = "Name of the libvirt storage pool"
  
}

variable "k3s_node_img_name" {
    type        = string
    default     = "ubuntu-24.04.qcow2"
    description = "Name of the K3s node image volume"
  
}

variable "k3s_node_img_id" {
    type        = string
    description = "ID of the K3s node image volume"
    default     = null
  
}

