output "redhat9_ip" {
  description = "Dirección IP de la VM Red Hat 9"
  value       = proxmox_vm_qemu.redhat9.network_interface[0].ip
}

output "win11_ip" {
  description = "Dirección IP de la VM Windows 11"
  value       = proxmox_vm_qemu.win11.network_interface[0].ip
}
