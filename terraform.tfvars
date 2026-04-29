k3s_nodes = [{
        libvirt_uri = "qemu+ssh://root@192.168.31.97/system"
        hostname = "k3s-node-1",
        ip = "192.168.31.88",
        username = "pdk",
        password = "$6$rounds=4096$3CcjsamHsBSOXYVu$OqKAuRqMMR6TRZNez/wwAVZSTjtye3XIhkT59F6.E2YDgbC52orN05Bgt3dG54/4/.gdiXT0O.cplOEbnpJAr0",  # Replace with your desired password
        mac = "52:54:00:12:34:58"  # Example MAC address, adjust as needed
        netmask = "24"
        nameservers = ["8.8.8.8", "114.114.114.114"]
        gateway = "192.168.31.1"
    },
    {
        libvirt_uri = "qemu+ssh://root@192.168.31.92/system"
        hostname = "k3s-node-2",
        ip = "192.168.31.89",
        username = "pdk",
        password = "$6$rounds=4096$3CcjsamHsBSOXYVu$OqKAuRqMMR6TRZNez/wwAVZSTjtye3XIhkT59F6.E2YDgbC52orN05Bgt3dG54/4/.gdiXT0O.cplOEbnpJAr0",  # Replace with your desired password
        mac = "52:54:00:12:34:59"  # Example MAC address, adjust as needed
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
base_img_name = "ubuntu-26.04.qcow2"
libvirt_uri = "qemu+ssh://root@192.168.31.97/system"
#libvirt_uri = "qemu+ssh://root@192.168.31.92/system"
