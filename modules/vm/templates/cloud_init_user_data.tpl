#cloud-config
ssh_pwauth: true
users:
  - name: ${username}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${ssh_key}
    groups: sudo
    shell: /bin/bash
    lock_passwd: false
    plain_text_passwd: false
    passwd: ${password}
locale: zh_CN.UTF-8
timezone: Asia/Shanghai
final_message: |
  cloud-init has finished
  version: $version
  timestamp: $timestamp
  datasource: $datasource
  uptime: $uptime
growpart:
  mode: auto
disk_setup:
  /dev/vdb:
    table_type: gpt
    layout: true
    overwrite: false
fs_setup:
  - label: data-disk
    device: /dev/vdb1
    filesystem: ext4
    overwrite: false
mounts:
  - [ /dev/vdb1, /data ]
package_update: true
package_upgrade: true
packages:
  - qemu-guest-agent

runcmd:
%{ for host,ip in hosts }
  - echo ${ip} ${host} >> /etc/hosts
%{ endfor ~}
  - systemctl enable --now qemu-guest-agent