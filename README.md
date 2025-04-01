# Terraform para Proxmox: Creación de VMs

![Linux Spartan](https://example.com/linux-spartan.png)

Este proyecto utiliza Terraform para automatizar la creación de máquinas virtuales (VMs) en un entorno Proxmox. El código está diseñado para ser modular y reutilizable, permitiendo la creación de múltiples VMs con configuraciones personalizadas.

## Estructura del Proyecto

```
/home/maxreig/personal/proxmox/
├── main.tf                     # Archivo principal que utiliza módulos para crear VMs
├── variables.tf                # Definición de variables globales
├── outputs.tf                  # Salidas de Terraform
├── terraform.tfvars.example    # Ejemplo de archivo para definir valores de variables
├── provisioning/
│   └── redhat9.sh              # Script de aprovisionamiento para Red Hat 9
├── tfmodules/
│   └── vm/
│       ├── main.tf             # Lógica del módulo para crear VMs
│       ├── variables.tf        # Variables del módulo
│       └── outputs.tf          # Salidas del módulo
└── README.md                   # Documentación del proyecto
```

## Requisitos Previos

1. **Proxmox**:
   - Un entorno Proxmox configurado y accesible.
   - Plantillas de VM disponibles en el almacenamiento de Proxmox:
     - Red Hat 9 (`redhat9-template`)
     - Windows 11 (`win11-template`)

2. **Terraform**:
   - Instalar Terraform en tu máquina local. [Guía de instalación](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

3. **Credenciales de Proxmox**:
   - Usuario y contraseña con permisos para crear VMs.

4. **Dependencias en la plantilla de Red Hat 9**:
   - Herramientas como `lvm2` y `e2fsprogs` deben estar instaladas para que el script de aprovisionamiento funcione correctamente.

## Configuración

### 1. Variables Globales

Define las variables globales en un archivo `terraform.tfvars` basado en el ejemplo proporcionado (`terraform.tfvars.example`):

```plaintext
proxmox_api_url    = "https://proxmox.example.com:8006/api2/json"
proxmox_user       = "root@pam"
proxmox_password   = "your_password"
proxmox_node       = "pve-node1"
proxmox_storage    = "local"
proxmox_bridge     = "vmbr0"

redhat9_template   = "redhat9-template"
win11_template     = "win11-template"

redhat9_ssh_user   = "root"
redhat9_ssh_password = "your_redhat9_password"
```

### 2. Módulo `vm`

El módulo `vm` se encuentra en `tfmodules/vm/` y define la lógica para crear una VM. Soporta:
- Configuración de discos.
- Configuración de múltiples interfaces de red.
- Aprovisionamiento opcional mediante SSH.

### 3. Script de Aprovisionamiento

El script `provisioning/redhat9.sh` configura LVM en la VM de Red Hat 9:
- Crea volúmenes lógicos para `/opt`, `/usr`, `/tmp`, `/var`, `/home` y un volumen de datos en `/mnt/data`.
- Añade los puntos de montaje a `/etc/fstab` para persistencia.

## Uso

### 1. Inicializar Terraform
Ejecuta el siguiente comando para inicializar el proyecto:
```bash
terraform init
```

### 2. Planificar la Infraestructura
Genera un plan para revisar los cambios que se aplicarán:
```bash
terraform plan
```

### 3. Aplicar los Cambios
Aplica los cambios para crear las VMs:
```bash
terraform apply
```

### 4. Verificar las Salidas
Una vez completado, Terraform mostrará las direcciones IP de las VMs creadas:
```plaintext
Outputs:
redhat9_ip = "192.168.1.100"
win11_ip = "192.168.1.101"
```

## Detalles Técnicos

### `main.tf`
- Define el proveedor Proxmox.
- Usa el módulo `vm` para crear las VMs `redhat9_vm` y `win11_vm`.
- Configura discos y redes para cada VM.

### `tfmodules/vm/main.tf`
- Configura los recursos de Proxmox para crear una VM.
- Soporta múltiples discos y redes.
- Incluye aprovisionamiento opcional mediante SSH.

### `provisioning/redhat9.sh`
- Configura LVM en la VM de Red Hat 9.
- Crea y monta volúmenes lógicos para los sistemas de archivos típicos de Linux.

## Notas

- **Persistencia de Montajes**: El script de aprovisionamiento asegura que los puntos de montaje persistan tras un reinicio.
- **Seguridad**: No incluyas contraseñas sensibles en el repositorio. Usa un archivo `.gitignore` para excluir `terraform.tfvars`.

## Contribuciones

Si deseas contribuir a este proyecto, crea un fork y envía un pull request con tus cambios.

## Licencia

Este proyecto está bajo la licencia MIT.

---

### Somos #NoSoloLinux

---
