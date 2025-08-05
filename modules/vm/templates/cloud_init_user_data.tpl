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

package_update: true
package_upgrade: true
packages:
  - qemu-guest-agent

runcmd:
${k3s_hosts_set}
  - systemctl enable --now qemu-guest-agent