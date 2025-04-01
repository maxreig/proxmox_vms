output "vm_ip" {
  description = "Dirección IP de la VM"
  value       = proxmox_vm_qemu.vm.network_interface[0].ip
}
