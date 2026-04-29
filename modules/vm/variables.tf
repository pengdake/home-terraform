variable "vm_cpu" {
    type        = number
    default     = 8
    description = "Number of vCPUs for each K3s node"
}

variable "vm_current_cpu" {
    type        = number
    default     = 6
    description = "Current number of vCPUs for each K3s node"
  
}

variable "vm_memory" {
    type        = number
    default     = 16 * 1024 * 1024  # 16 GB in KB
    description = "Memory size in KB for each K3s node"
}

variable "vm_current_memory" {
    type        = number
    default     = 12 * 1024 * 1024  # 16 GB in KB
    description = "Current memory size in KB for each K3s node"
}

variable "vm_disk_size" {
    type        = number
    default     = 300 * 1024 * 1024 * 1024  # 300 GB
    description = "Disk size in bytes for each K3s node"
  
}

variable "vm_root_size" {
    type        = number
    default     = 30 * 1024 * 1024 * 1024  # 30 GB
    description = "Root disk size in bytes for each K3s node"
  
}


variable "libvirt_pool_name" {
    type        = string
    default     = "default"
    description = "Name of the libvirt storage pool"
  
}

variable "libvirt_pool_path" {
    type        = string
    default     = "/var/lib/libvirt/images"
    description = "Path for the default libvirt storage pool"
  
}


variable "default_network" {
    type        = string
    default     = "default"
    description = "Default network name for K3s nodes"
  
}

variable "ssh_public_key" {
    type        = string
    default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+B4nZpd1lHkQ/SLDw+OggtvBi+JCv3moy5dcWokQvS pdk@jmk"
    description = "SSH public key for K3s nodes"
  
}

variable "hostname" {
    type        = string
    description = "Host name for the K3s node"  
  
}

variable "ip" {
    type        = string
    description = "IP address for the K3s node"
  
}

variable "username" {
    type        = string
    description = "Username for the K3s node"
  
}

variable "password" {
    type        = string
    description = "Password for the K3s node"
  
}

variable "mac" {
    type        = string
    description = "MAC address for the K3s node"
  
}   

variable "netmask" {
    type        = string
    description = "Netmask for the K3s node"
  
}

variable "nameservers" {
    type        = list(string)
    description = "List of nameservers for the K3s node"
}

variable "gateway" {
    type        = string
    description = "Gateway for the K3s node"
  
}

variable "k3s_hosts" {
    type        = map(string)
    description = "Map of K3s node hostnames to their IP addresses"
  
}

variable "network_id" {
    type        = string
    description = "ID of the network to attach K3s nodes to"
    default     = null
}

variable "base_img_path" {
    type        = string
    description = "Path to the base image for K3s nodes"
    default     = null
}

variable "vnc_password" {
    type        = string
    description = "Password for VNC access to the K3s nodes"
    default     = "abc123"  # Replace with your desired VNC password
  
}


variable "bridge_network" {
    type        = string
    description = "Bridge network name for K3s nodes"
    default     = null
}
