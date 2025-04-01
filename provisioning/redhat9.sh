#!/bin/bash

set -e  # Detener el script si ocurre un error

# Función para crear un volumen lógico, formatearlo y montarlo
create_and_mount_lv() {
  local vg_name=$1
  local lv_name=$2
  local lv_size=$3
  local mount_point=$4

  lvcreate -L "$lv_size" -n "$lv_name" "$vg_name"
  mkfs.ext4 "/dev/${vg_name}/${lv_name}"
  mkdir -p "$mount_point"
  mount "/dev/${vg_name}/${lv_name}" "$mount_point"

  # Añadir a /etc/fstab para persistencia
  echo "/dev/${vg_name}/${lv_name} $mount_point ext4 defaults 0 2" >> /etc/fstab
}

#############################################################################################
# Crear discos físicos y grupos de volúmenes
pvcreate /dev/sdb
vgcreate VG_OS /dev/sdb

pvcreate /dev/sdc
vgcreate VG_DATOS /dev/sdc
#############################################################################################

# Crear y montar volúmenes lógicos en VG_OS
create_and_mount_lv "VG_OS" "lv_opt" "5G" "/opt"
create_and_mount_lv "VG_OS" "lv_usr" "10G" "/usr"
create_and_mount_lv "VG_OS" "lv_tmp" "2G" "/tmp"
create_and_mount_lv "VG_OS" "lv_var" "5G" "/var"
create_and_mount_lv "VG_OS" "lv_home" "1G" "/home"

# Crear y montar volumen lógico en VG_DATOS
create_and_mount_lv "VG_DATOS" "lv_data" "100G" "/mnt/data"

#############################################################################################
echo "Configuración de LVM completada con éxito."