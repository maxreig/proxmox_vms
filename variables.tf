variable "proxmox_api_url" {
  description = "URL de la API de Proxmox"
  type        = string
}

variable "proxmox_user" {
  description = "Usuario de Proxmox"
  type        = string
}

variable "proxmox_password" {
  description = "Contraseña de Proxmox"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Nodo de Proxmox donde se crearán las VMs"
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

variable "redhat9_template" {
  description = "Plantilla base para Red Hat 9"
  type        = string
}

variable "win11_template" {
  description = "Plantilla base para Windows 11"
  type        = string
}

variable "redhat9_ssh_user" {
  description = "Usuario SSH para Red Hat 9"
  type        = string
}

variable "redhat9_ssh_password" {
  description = "Contraseña SSH para Red Hat 9"
  type        = string
  sensitive   = true
}
