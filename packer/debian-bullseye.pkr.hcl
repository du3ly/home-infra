{
  "variables": {
    "proxmox-user": "apiuser@pve",
    "proxmox-token": "supersecret"
  },
  "builders": [
    {
      "type": "proxmox",
      "proxmox_url": "https://192.168.0.20:8006/api2/json",
      "insecure_skip_tls_verify": true,
      "username": "{{user `proxmox-user`}}",
      "password": "{{user `proxmox-token`}}",

      "node": "proxmox-001",
      "network_adapters": [
        {
          "bridge": "vmbr0"
        }
      ],
      "disks": [
        {
          "type": "scsi",
          "disk_size": "32G",
          "storage_pool": "local-lvm",
          "storage_pool_type": "lvm"
        }
      ],

      "iso_file": "local:iso/Fedora-Server-dvd-x86_64-29-1.2.iso",
      "http_directory": "config",
      "boot_wait": "10s",
      "boot_command": [
        "<up><tab> ip=dhcp inst.cmdline inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ks.cfg<enter>"
      ],

      "ssh_timeout": "15m",
      "ssh_username": "root",
      "ssh_password": "packer",

      "unmount_iso": true,
      "template_name": "debian-bullseye",
      "template_description": "Debian Bullseye, generated on {{ isotime \"2006-01-02T15:04:05Z\" }}"
    }
  ]
}
