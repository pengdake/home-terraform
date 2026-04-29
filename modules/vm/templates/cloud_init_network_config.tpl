network:
  version: 2
  ethernets:
    enp0s3:
      match:
        macaddress: "${mac}"
      set-name: enp0s3
      dhcp4: false
      addresses:
        - ${ip}/${netmask}
      routes:
        - to: default
          via: ${gateway}
      nameservers:
        addresses: [${nameservers}]
