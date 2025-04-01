// Configuración del proveedor Proxmox
provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_user    = var.proxmox_user
  pm_password = var.proxmox_password
  pm_tls_insecure = true
}

// Módulo para la VM Red Hat 9
module "redhat9_vm" {
  source           = "./tfmodules/vm" // Ruta al módulo de VM
  vm_name          = "redhat9-vm"    // Nombre de la VM
  template         = var.redhat9_template // Plantilla base para la VM
  ssh_user         = var.redhat9_ssh_user // Usuario SSH para aprovisionamiento
  ssh_password     = var.redhat9_ssh_password // Contraseña SSH para aprovisionamiento
  disks            = [
    { id = 0, size = "50G" }, // Disco del sistema operativo
    { id = 1, size = "100G" } // Disco de datos
  ]
  networks         = [
    { model = "virtio", bridge = "vmbr0" },  // NIC 1: Producción
    { model = "virtio", bridge = "vmbr1" }   // NIC 2: Backup & Storage NAS
  ]
}

// Módulo para la VM Windows 11
module "win11_vm" {
  source           = "./tfmodules/vm" // Ruta al módulo de VM
  vm_name          = "win11-vm"      // Nombre de la VM
  template         = var.win11_template // Plantilla base para la VM
  ssh_user         = null // No se requiere aprovisionamiento SSH
  ssh_password     = null // No se requiere aprovisionamiento SSH
  disks            = [
    { id = 0, size = "50G" }, // Disco del sistema operativo
    { id = 1, size = "100G" } // Disco de datos
  ]
  networks         = [
    { model = "virtio", bridge = "vmbr0" },  // NIC 1: Producción
    { model = "virtio", bridge = "vmbr1" }   // NIC 2: Backup & Storage NAS
  ]
}
