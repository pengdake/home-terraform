network:
  version: 2
  ethernets:
    ens3:
      dhcp4: false
      addresses:
        - ${ip}/${netmask}
      gateway4: ${gateway}
      nameservers:
        addresses: [${nameservers}]
