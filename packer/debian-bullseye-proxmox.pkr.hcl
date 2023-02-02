source "proxmox" "debian_bullseye" {
  boot_command = [
    "<wait><wait><wait><esc><wait><wait><wait>",
    "/install.amd/vmlinuz ",
    "initrd=/install.amd/initrd.gz ",
    "auto=true ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.preseed_file} ",
    "hostname=packer ",
    "domain=hsd1.il.comcast.net. ",
    "interface=auto ",
    "vga=788 noprompt quiet --<enter>"
  ]
  boot_wait    = "10s"
  cloud_init   = true
  cloud_init_storage_pool = "vmstore"
  disks {
    disk_size         = "32G"
    storage_pool      = "vmstore"
    storage_pool_type = "lvm"
    type              = "scsi"
  }
  http_content             = { "/${var.preseed_file}" = templatefile(var.preseed_file, { var = var }) }
  insecure_skip_tls_verify = true
  iso_file                 = "local:iso/debian-11.6.0-amd64-netinst.iso"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  memory               = "1024"
  node                 = "proxmox-001"
  proxmox_url          = "https://192.168.0.20:8006/api2/json"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "15m"
  ssh_username         = "${var.ssh_username}"
  template_description = "Debian Bullseye, generated on ${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  template_name        = "debian-bullseye"
  token                = "${var.proxmox_token}"
  unmount_iso          = true
  username             = "${var.proxmox_user}"
  vm_id                = 200
}

build {
  sources = ["source.proxmox.debian_bullseye"]

  provisioner "file" {
      destination = "/tmp/requirements.txt"
      source = "../requirements.txt"
  }

  provisioner "shell" {
    execute_command = "{{.Vars}} sudo -S -E bash '{{.Path}}'"
    scripts = [
      "scripts/ansible.sh"
    ]
  }

  provisioner "ansible-local" {
    command = "ANSIBLE_FORCE_COLOR=1 PYTHONUNBUFFERED=1 ansible-playbook"
    extra_arguments= [
      "-e 'ansible_python_interpreter=/usr/bin/python3'"
    ]
    inventory_groups = ["all"]
    playbook_dir = "../ansible"
    playbook_file = "../ansible/playbooks/operators.yml"
  }

  provisioner "shell" {
    execute_command = "{{.Vars}} sudo -S -E bash '{{.Path}}'"
    expect_disconnect = "true"
    scripts = [
      "scripts/cleanup.sh"
    ]
  }
}
