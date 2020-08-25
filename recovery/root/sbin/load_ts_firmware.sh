#!/sbin/sh

module_path=/sbin/modules

# Load all needed modules
insmod $module_path/sensors_class.ko
insmod $module_path/aw8695.ko
insmod $module_path/aw882xx_k419.ko
insmod $module_path/nova_0flash_mmi.ko
insmod $module_path/utags.ko
insmod $module_path/exfat.ko
insmod $module_path/mmi_annotate.ko
insmod $module_path/mmi_info.ko
insmod $module_path/mmi_sys_temp.ko
insmod $module_path/moto_f_usbnet.ko
insmod $module_path/qpnp-smbcharger-mmi.ko
insmod $module_path/qpnp-power-on-mmi.ko

echo 1 > proc/nvt_update

return 0

