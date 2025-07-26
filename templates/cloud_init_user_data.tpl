# cloud-config
ssh_pwauth: True
users:
  - name: ${username}
    ssh-authorized-keys:
      - ${ssh_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    shell: /bin/bash
    lock_passwd: false
    plain_text_passwd: true
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
  {% for hostname, ip in hosts %}
  - echo ${ip} ${hostname} >> /etc/hosts
  {% endfor %}
  - systemctl enable --now qemu-guest-agent

