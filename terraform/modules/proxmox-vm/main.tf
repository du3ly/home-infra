resource "proxmox_vm_qemu" "this" {
  name        = var.vm_name
  target_node = var.target_node
  clone       = var.vm_clone_template
  desc        = var.vm_desc

  # Resources
  memory = var.memory
  cores  = var.cores

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = var.disk_storage
    size    = var.disk_size
  }

  # Enable QEMU Guest Agent
  agent = 1
}
