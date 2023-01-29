# Packer

## Install with Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/packer
brew upgrade hashicorp/tap/packer

## Create user, role, and token for Packer
pveum role add Packer -privs "Datastore.AllocateSpace Sys.Modify VM.Config.Disk VM.Config.CPU VM.Config.Memory VM.Config.Options VM.Allocate VM.Audit VM.Console VM.Config.CDROM VM.Config.Network VM.PowerMgmt VM.Config.HWType VM.Monitor"
pveum user add packer@pve -comment "Packer API user"
pveum acl modify / -user packer@pve -role Packer
pveum user token add packer@pve packer1

pveum acl modify / --users packer@pve
pveum acl modify / --tokens packer@pve!packer1

## How to use Packer
source secrets
packer validate .
packer build .
