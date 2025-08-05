
variable "k3s_nodes" {
    type        = list(object({
        hostname = string
        ip   = string
        username = string
        password = string
        mac = string
        netmask = string
        nameservers = list(string)
        gateway = string
    }))
    default     = [{
            hostname = "k3s-node1",
            ip = "192.168.31.94",
            username = "pdk",
            password = "abc123",  # Replace with your desired password
            mac = "52:54:00:12:34:56"  # Example MAC address, adjust as needed
            netmask = "24"
            nameservers = ["8.8.8.8", "114.114.114.114"]
            gateway = "192.168.31.1"
        },
        {
            hostname = "k3s-node2",
            ip = "192.168.31.95",
            username = "pdk",
            password = "abc123",  # Replace with your desired password
            mac = "52:54:00:12:34:57"  # Example MAC address, adjust as needed
            netmask = "24"
            nameservers = ["8.8.8.8", "114.114.114.114"]
            gateway = "192.168.31.1"
        },
        {
            hostname = "k3s-node3",
            ip = "192.168.31.96",
            username = "pdk",
            password = "abc123",  # Replace with your desired password
            mac = "52:54:00:12:34:58"  # Example MAC address, adjust as needed
            netmask = "24"
            nameservers = ["8.8.8.8", "114.114.114.114"]
            gateway = "192.168.31.1"
        }
    ]
}

variable "libvirt_url" {
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
