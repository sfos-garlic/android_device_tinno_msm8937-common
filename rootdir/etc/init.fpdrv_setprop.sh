#!/vendor/bin/sh
export PATH=/vendor/bin

# fp_drv path
fp_driver=/sys/devices/platform/fp_drv
if [ -e "$fp_driver" ]
then
    # fp_drv_info
    file=/sys/devices/platform/fp_drv/fp_drv_info
    if [ -f "$file" ]
     then
      fp_drv_file=`cat /sys/devices/platform/fp_drv/fp_drv_info`
	case "$fp_drv_file" in
                    "silead_fp")
                    setprop ro.hardware.fingerprint silead
                    setprop persist.sys.fp.goodix 0
                              ;;
                    "goodix_fp")
                    setprop ro.hardware.fingerprint goodix
                    setprop persist.sys.fp.goodix 1
                              ;;
                    "elan_fp")
                    setprop ro.hardware.fingerprint elan
                    setprop persist.sys.fp.goodix 0
                              ;;
                    "chipone_fp")
                    setprop ro.hardware.fingerprint chipone
                    setprop persist.sys.fp.goodix 0
                              ;;
	esac
      echo "Loading Fingerprint HAL for sensor version" $fp_drv_file
    else
      echo "Failed to detect Fingerprint sensor version"
                    setprop ro.hardware.fingerprint none
                    setprop persist.sys.fp.goodix 0
    fi
fi
