module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name           = "nomad-001"
  vm_clone_template = "debian-bullseye"

  cores = 2
  memory = 4096
}
