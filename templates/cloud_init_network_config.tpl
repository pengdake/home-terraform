network:
  version: 2
  ethernets:
    eth0:
      match:
        macaddress: ${mac}
      dhcp4: false
      addresses: 
        - ${ip}/${netmask}
      set-name: eth0
      gateway4: ${gateway}
      nameservers:
        addresses: [${join(", ", nameservers)}]
