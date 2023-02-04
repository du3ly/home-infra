terraform {
  # Partial configuration
  # Backend conn_str configured with env variable 
  # export TF_CLI_ARGS="-backend-config='conn_str=postgres://user:pass@host/terraform'"
  backend "pg" {}
}

module "instance" {
  source = "../../../modules/proxmox-vm"

  vm_name           = "vault"
  vm_clone_template = "debian-bullseye"
}
