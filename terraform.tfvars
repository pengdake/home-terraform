k3s_nodes = [{
        libvirt_uri = "qemu+ssh://root@192.168.31.97/system"
        hostname = "k3s-node1",
        ip = "192.168.31.94",
        username = "pdk",
        password = "$6$rounds=4096$3CcjsamHsBSOXYVu$OqKAuRqMMR6TRZNez/wwAVZSTjtye3XIhkT59F6.E2YDgbC52orN05Bgt3dG54/4/.gdiXT0O.cplOEbnpJAr0",  # Replace with your desired password
        mac = "52:54:00:12:34:56"  # Example MAC address, adjust as needed
        netmask = "24"
        nameservers = ["8.8.8.8", "114.114.114.114"]
        gateway = "192.168.31.1"
    },
    {
        libvirt_uri = "qemu+ssh://root@192.168.31.92/system"
        hostname = "k3s-node2",
        ip = "192.168.31.95",
        username = "pdk",
        password = "$6$rounds=4096$3CcjsamHsBSOXYVu$OqKAuRqMMR6TRZNez/wwAVZSTjtye3XIhkT59F6.E2YDgbC52orN05Bgt3dG54/4/.gdiXT0O.cplOEbnpJAr0",  # Replace with your desired password
        mac = "52:54:00:12:34:57"  # Example MAC address, adjust as needed
        netmask = "24"
        nameservers = ["8.8.8.8", "114.114.114.114"]
        gateway = "192.168.31.1"
    },
#    {
#        libvirt_uri = "qemu+ssh://root@192.168.31.97/system"
#        hostname = "k3s-node3",
#        ip = "192.168.31.96",
#        username = "pdk",
#        password = "$6$rounds=4096$3CcjsamHsBSOXYVu$OqKAuRqMMR6TRZNez/wwAVZSTjtye3XIhkT59F6.E2YDgbC52orN05Bgt3dG54/4/.gdiXT0O.cplOEbnpJAr0",  # Replace with your desired password
#        mac = "52:54:00:12:34:58"  # Example MAC address, adjust as needed
#        netmask = "24"
#        nameservers = ["8.8.8.8", "114.114.114.114"]
#        gateway = "192.168.31.1"
#    }
]

k3s_node_img_id = "/var/lib/libvirt/images/ubuntu-24.04.qcow2"
#libvirt_uri = "qemu+ssh://root@192.168.31.97/system"
libvirt_uri = "qemu+ssh://root@192.168.31.92/system"
