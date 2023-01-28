variable "proxmox_token" {
  type    = string
  default = "${env("PROXMOX_TOKEN")}"
}

variable "proxmox_user" {
  type    = string
  default = "packer@pve!packer1"
}

variable "preseed_file" {
  type    = string
  default = "http/debian-bullseye.preseed"
}

variable "ssh_username" {
  type    = string
  default = "ansible"
}

variable "ssh_password" {
  type    = string
  default = "${env("SSH_PASSWORD")}"
}
