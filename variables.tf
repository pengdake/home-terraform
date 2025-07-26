
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

variable "k3s_hosts" {
    type        = map(string)
    description = "Map of K3s node hostnames to their IP addresses"
    default     = { for node in var.k3s_nodes : node.hostname => node.ip }
  
}
