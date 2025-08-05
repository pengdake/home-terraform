variable "vm_cpu" {
    type        = number
    default     = 4
    description = "Number of vCPUs for each K3s node"
}

variable "vm_memory" {
    type        = number
    default     = 12288
    description = "Memory size in MB for each K3s node"
}

variable "vm_disk_size" {
    type        = number
    default     = 100 * 1024 * 1024 * 1024  # 100 GB
    description = "Disk size in bytes for each K3s node"
  
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

variable "k3s_node_img_id" {
    type        = string
    description = "Base image volume for K3s nodes"
    default     = null 
}
