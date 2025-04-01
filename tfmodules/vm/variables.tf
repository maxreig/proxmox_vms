variable "vm_name" {
  description = "Nombre de la máquina virtual"
  type        = string
}

variable "template" {
  description = "Plantilla base para la VM"
  type        = string
}

variable "proxmox_node" {
  description = "Nodo de Proxmox donde se creará la VM"
  type        = string
}

variable "proxmox_storage" {
  description = "Almacenamiento de Proxmox para los discos"
  type        = string
}

variable "proxmox_bridge" {
  description = "Bridge de red de Proxmox"
  type        = string
}

variable "ssh_user" {
  description = "Usuario SSH para la VM"
  type        = string
  default     = null
}

variable "ssh_password" {
  description = "Contraseña SSH para la VM"
  type        = string
  default     = null
  sensitive   = true
}

variable "disks" {
  description = "Lista de discos para la VM"
  type = list(object({
    id   = number
    size = string
  }))
}

variable "provisioning_script" {
  description = "Ruta al script de aprovisionamiento"
  type        = string
  default     = "provisioning/redhat9.sh"
}

variable "networks" {
  description = "Lista de redes para la VM"
  type = list(object({
    model  = string
    bridge = string
  }))
}
