# Terraform with Proxmox

Information about the Proxmox provider and the commands to create the users and role can be found in the terraform.io webpage.

https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
https://github.com/Telmate/terraform-provider-proxmox

Commands

```
pveum role add TerraformProv -privs "VM.Allocate VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Monitor VM.Audit VM.PowerMgmt Datastore.AllocateSpace Datastore.Audit"
pveum user add terraform-prov@pve
pveum acl modify / --role TerraformProv --user terraform-prov@pve
pveum acl modify / --role TerraformProv --tokens 'terraform-prov@pve!terraform1'
```
