terraform {
  backend "pg" {}
}

module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name           = "vault"
  vm_clone_template = "debian-bullseye"
}
