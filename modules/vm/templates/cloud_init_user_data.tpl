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
  /dev/vdc:
    table_type: gpt
    layout: true
    overwrite: false
fs_setup:
  - label: data-disk
    device: /dev/vdb1
    filesystem: ext4
    overwrite: false
  - label: rancher-disk
    device: /dev/vdc1
    filesystem: ext4
    overwrite: false
mounts:
  - [ /dev/vdb1, /data ]
  - [ /dev/vdc1, /var/lib/rancher ]
apt:
  preserve_sources_list: true
package_update: true
packages:
  - qemu-guest-agent

bootcmd:
%{ for host,ip in hosts }
  - echo ${ip} ${host} >> /etc/hosts
%{ endfor ~}

runcmd:
  - systemctl stop unattended-upgrades apt-daily.timer apt-daily-upgrade.timer multipathd
  - systemctl disable unattended-upgrades apt-daily.timer apt-daily-upgrade.timer multipathd
  - systemctl enable --now qemu-guest-agent
  - systemctl restart qemu-guest-agent