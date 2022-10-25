#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode

# start script
# $1:value $2:file path
lock_val() 
{
 if [ -f ${2} ]; then
  chmod 0666 ${2}
  echo ${1} > ${2}
  chmod 0444 ${2}
 fi
}

# suppress stderr
(

# disable thermal for kernel build 4.9
for i in $(find /sys/devices/virtual/thermal -type f -iname "mode"); do
 lock_val "0" $i
 lock_val "disabled" $i
done

# suppress stderr end
) 2>/dev/null
exit
