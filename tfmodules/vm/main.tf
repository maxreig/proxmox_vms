resource "proxmox_vm_qemu" "vm" {
  name       = var.vm_name       // Nombre de la VM
  target_node = var.proxmox_node // Nodo de Proxmox donde se creará la VM
  clone      = var.template      // Plantilla base para clonar la VM

  // Configuración de discos
  dynamic "disk" {
    for_each = var.disks
    content {
      id      = disk.value.id      // ID del disco
      size    = disk.value.size    // Tamaño del disco
      type    = "scsi"             // Tipo de disco
      storage = var.proxmox_storage // Almacenamiento en Proxmox
    }
  }

  // Configuración de redes
  dynamic "network" {
    for_each = var.networks
    content {
      model  = network.value.model  // Modelo de la NIC
      bridge = network.value.bridge // Bridge de red
    }
  }

  // Aprovisionamiento opcional con un script
  provisioner "file" {
    source      = var.provisioning_script // Ruta al script de aprovisionamiento
    destination = "/tmp/provisioning.sh"  // Destino en la VM
    when        = var.ssh_user != null && var.ssh_password != null // Solo si se configuran credenciales SSH
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provisioning.sh", // Dar permisos de ejecución al script
      "/tmp/provisioning.sh"          // Ejecutar el script
    ]
    connection {
      type     = "ssh"                // Tipo de conexión
      user     = var.ssh_user         // Usuario SSH
      password = var.ssh_password     // Contraseña SSH
      host     = self.network_interface[0].ip // Dirección IP de la VM
    }
    when = var.ssh_user != null && var.ssh_password != null // Solo si se configuran credenciales SSH
  }
}
